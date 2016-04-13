class Admin::ProblemsController < ApplicationController
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
    @problems = Problem.all
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem_test_cases = ProblemTestCase.where(problemid: params[:id])
    @myid = params[:id]
    @courses = @problem.courses
  end


  # GET /problems/new
  def new
    @problem = Problem.new
    
    @courses = Course.all
    @rels = Hash.new(false)
    
    if params.include?(:courseid) and params[:courseid].size > 0
      @rels[params[:courseid].to_i] = true
    end
  end

  # GET /problems/1/edit
  def edit
    @courses = Course.all
    rels = CourseProblemRelation.where(:problem => @problem.id)
    @rels = Hash.new(false)
    rels.each do |rel|
      @rels[rel.course] = true
    end
  end

  # POST /problems
  # POST /problems.json
  def create
    @problem = Problem.new(problem_params)

    respond_to do |format|
      if @problem.save
        relate_with_courses
      #  if params.include?(:courseid) and params[:courseid].size > 0
      #    CourseProblemRelation.relate!(params[:courseid], @problem.id)
      #  end
        format.html { redirect_to admin_problem_path(@problem), notice: 'Problem was successfully created.' }
        format.json { render :show, status: :created, location: @problem }
      else
        format.html { render :new }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problems/1
  # PATCH/PUT /problems/1.json
  def update
    relate_with_courses
    
    respond_to do |format|
      if @problem.update(problem_params)
        format.html { redirect_to admin_problem_path(@problem), notice: 'Problem was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem }
      else
        format.html { render :edit }
        format.json { render json: @problem.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problems/1
  # DELETE /problems/1.json
  def destroy
    CourseProblemRelation.destroy_by_problem(@problem.id)
    @problem.destroy
    respond_to do |format|
      format.html { redirect_to admin_problems_url, notice: 'Problem was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  
  def submission
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:title, :summary, :input_description, :output_description, :skeleton, :due_date, :language)
    end
    
    def relate_with_courses
    # Extremely lazy way of doing things.  Just erase all and rewrite them.  At least it works.
      CourseProblemRelation.destroy_by_problem(@problem.id)
      courses = Course.all
      courses.each do |course|
        id = "course-checkbox-#{course.id}"
        if(params.include?(id) and params[id])
          CourseProblemRelation.relate!(course.id, @problem.id)
        end
      end
    end
end
