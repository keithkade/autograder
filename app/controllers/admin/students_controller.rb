require 'json'
require 'pp'

class Admin::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
  # Remember which option was selected for course filtering
  
    if params.include?(:courseid)
      session[:students_list_courseid] = params[:courseid]
    elsif session.include?(:students_list_courseid)
      redirect_to admin_students_path(:courseid => session[:students_list_courseid])
    else
      redirect_to admin_students_path(:courseid => -1)
    end
  # @courseid is used in the view to set the default option in the select field
    @courseid = params[:courseid].to_i
    @courses = Course.order(:name)
    @students = Student.order(:LastName)
    @students.each do |student|
      #getGrade(student.id)
    end

  # A negative courseid is used to select all students
    if @courseid >= 0
    # Literally: Keep if the courseid is in the students' list of courses
      @students = Array(@students).keep_if { |student| student.courses.map { |course| course.id }.include?(@courseid) }
    end
  end

  def sort
    if (@student.find{|student| student.problems_grade = nil})
      flash[:notice] = "all students must have a grade assigned!"
      redirect_to admin_student_path
      else
        @students.sort_by(&:Problems_grade).reverse.each do |student|
      end
    end
  end


  # GET /students/1
  # GET /students/1.json
  def show
    @courses = @student.courses
    @submissions = Submission.order('time_submitted DESC').where(:student_id => @student.id)
    @problemNames = Hash.new

    @testCaseResults = []

    @submissions.each do |submission|

      #TODO write test for these
      problem = Problem.find_by_id(submission.problem_id)
      if not problem.nil?
        @problemNames[submission.problem_id] = problem.title
      end

      if submission.total_cases > 0
        @testCaseResults.push(submission.success_cases.to_s + '/' + submission.total_cases.to_s)
      else
        @testCaseResults.push('Compile Error')
      end
    end
  end

  # GET /students/new
  def new
    @student = Student.new
    @courses = Course.all
    rels = CourseUserRelation.where(:user => @student.id)
    @rels = Hash.new(false)
    rels.each do |rel|
      @rels[rel.course] = true
    end
  end

  # GET /students/1/edit
  def edit
    @courses = Course.all
    rels = CourseUserRelation.where(:user => @student.id)
    @rels = Hash.new(false)
    rels.each do |rel|
      @rels[rel.course] = true
    end
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        relate_with_courses
        format.html { redirect_to admin_student_path(@student), notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    relate_with_courses
    
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to admin_student_path(@student), notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    CourseUserRelation.destroy_by_user(@student.id)
    @student.destroy
    respond_to do |format|
      format.html { redirect_to admin_students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:FirstName, :ID, :UserName, :Password, :LastName, :Quizs_grade, :Problems_grade)
    end
    
    def relate_with_courses
    # Extremely lazy way of doing things.  Just erase all and rewrite them.  At least it works.
      CourseUserRelation.destroy_by_user(@student.id)
      courses = Course.all
      courses.each do |course|
        id = "course-checkbox-#{course.id}"
        if(params.include?(id) and params[id])
          CourseUserRelation.relate!(course.id, @student.id)
        end
      end
    end
end
