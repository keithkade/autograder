class Admin::CoursesController < ApplicationController
  require 'fileutils'

  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    @courses = Course.order(:name).where(:is_archived => false)
    if params[:semester] == nil
      @semester = 'All'
    elsif params[:semester] != 'All'
      @semester = params[:semester]
      @courses = @courses.where(semester: @semester)
    end
    if params[:year] == nil
      @year = Time.now.year
      @courses = @courses.where(year: @year)
    elsif not params[:year].empty?
      @year = params[:year]
      @courses = @courses.where(year: @year)
    end
    pp @semester
    # if not params.include?(:semester)
    #   @courses = @courses.where(year: @year)
    # if (params[:semester] == 'All' && params[:year] == '')
    #   @courses = @courses
    # elsif (params[:semester] != '' && params[:year] == '')
    #   @courses = @courses.where(semester: params[:semester])
    # elsif (params[:semester] == 'All' && params[:year] != '')
    #   @courses = @courses.where(year: params[:year])
    # elsif
    #   @courses = @courses.where(year: params[:year], semester: params[:semester])
    # end  
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
    @myid = params[:id]
    @students = @course.users
    @problems = @course.problems
  end

  # GET /courses/new
  def new
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    logger.debug admin_courses_path(@course)

    respond_to do |format|
      if @course.save
        format.html { redirect_to admin_course_path(@course), notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: admin_courses_path(@course) }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to admin_course_path(@course), notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # POST /courses/1/download
  def download
    students = Course.find(params[:courseid]).users
    File.open("roster.csv", 'w') do |file|
      file.write("Id,Last Name,First Name,Problems Grade,Late Problems Grades,Quizzes Grade\n")
      for student in students do
        student.problems_grade
        student.quizs_grade
        pp student
        pp "delay"
        if(student.Quizs_grade == nil or student.Problems_grade == nil or student.lateProblemsGrade == nil)
          sleep(0.5)
        end
        file.write(student.ID.to_s + ',' + student.LastName + ',' + student.FirstName + ',' + student.Problems_grade + "," + student.lateProblemsGrade + "," + student.Quizs_grade + "\n")
      end
    end
    send_file(File.join(Rails.root, "roster.csv"))
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name, :semester, :year, :is_archived)
    end
end
