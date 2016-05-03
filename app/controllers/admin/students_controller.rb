require 'json'
require 'pp'

class Admin::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
  # Remember which option was selected for course filtering
  
    if params.include?(:estudiante) && params[:estudiante].length > 0 
     # @student = Student.find_by_id(:estudiante)
     #redirect_to admin_students_path(:courseid => params[:estudiante])
      #redirect_to action: "show", Student.find_by_id()
      if (params[:estudiante].first =~ /[[0-9]]/)
        @students = Student.where(:ID => params[:estudiante])
      else
        @students = Student.where(:LastName => params[:estudiante])
      end
      
    elsif params.include?(:courseid)
      session[:students_list_courseid] = params[:courseid]
    elsif session.include?(:students_list_courseid)
      redirect_to admin_students_path(:courseid => session[:students_list_courseid], :order => params[:order])
    else
      redirect_to admin_students_path(:courseid => -1, :order => params[:order])
    end
  # @courseid is used in the view to set the default option in the select field
    @courseid = params[:courseid].to_i
    @courses = Course.unarchived.order(:name)
    
    if (not params.include?(:estudiante))
      
      @students = Student.order(:LastName)
      @students.each do |student|
        student.problems_grade
      end
    

  # A negative courseid is used to select all students
      if @courseid >= 0
      # Literally: Keep if the courseid is in the students' list of courses
        @students = Array(@students).keep_if { |student| student.courses.map { |course| course.id }.include?(@courseid) }
      end
    end
    #sort
    if params.include?(:order)
      puts("############################SORTING#####################")
      sort
    end
    
  end

  #def sort
   # if (@student.find{|student| student.problems_grade = nil})
    #  flash[:notice] = "all students must have a grade assigned!"
     # redirect_to admin_student_path
    #  else
     #   @students.sort_by(&:Problems_grade).reverse.each do |student|
    #  end
  #  end
#  end

def sort
  @students = @students.sort_by do |student|
    g = student.Problems_grade.split('/')
    if (g[1] == "0")
      -1
    else
      g[0].to_f/g[1].to_f
    end
  end
  @students = @students.reverse
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
      
      
       if params.include?(:problem) 
        
        if (Problem.find_by_title(params[:problem]) == nil)
          #flash[:notice] = "No submission found for that problem!"
          @submissions = Submission.order('time_submitted DESC').where(:student_id => @student.id)
          #redirect_to admin_student_path(@student)
        else  
          @submissions = @student.submissions.where(:problem_id => Problem.find_by_title(params[:problem]).id)
          #flash[:notice] = "Submission(s) successfully found!" 
          #redirect_to admin_student_path(@student)
        end
    
        #if @submissions == nil
         # flash[:notice] = "No submission found for that problem"
          #@submissions = Submission.order('time_submitted DESC').where(:student_id => @student.id)
        #end
       
       end
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
    # @courses = Course.all
    # rels = CourseUserRelation.where(:user => @student.id)
    # @rels = Hash.new(false)
    # rels.each do |rel|
    #   @rels[rel.course] = true
    # end
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
    pp @student.UserName
    pp @student.is_archived
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
      params.require(:student).permit(:FirstName, :ID, :UserName, :password, :LastName, :Quizs_grade, :Problems_grade, :is_archived)
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
