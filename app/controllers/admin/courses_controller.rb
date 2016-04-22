class Admin::CoursesController < ApplicationController
  before_action :set_course, only: [:show, :edit, :update, :destroy]

  # GET /courses
  # GET /courses.json
  def index
    
    if (params[:semester] == 'All' && params[:year] == '')
      @courses = Course.all
    elsif (params[:semester] != '' && params[:year] == '')
      @courses = Course.where(semester: params[:semester])
    elsif (params[:semester] == 'All' && params[:year] != '')
      @courses = Course.where(year: params[:year])
    else
      @courses = Course.where(year: params[:year], semester: params[:semster])
    end
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
    CourseProblemRelation.destroy_by_course(@course.id)
    CourseUserRelation.destroy_by_course(@course.id)
    @course.destroy
    respond_to do |format|
      format.html { redirect_to admin_courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:name)
    end
end
