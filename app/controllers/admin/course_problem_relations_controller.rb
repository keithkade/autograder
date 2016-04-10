class Admin::CourseProblemRelationsController < ApplicationController
  before_action :set_course_problem_relation, only: [:show, :edit, :update, :destroy]

  # GET /course_problem_relations
  # GET /course_problem_relations.json
  def index
    @course_problem_relations = CourseProblemRelation.all
  end

  # GET /course_problem_relations/1
  # GET /course_problem_relations/1.json
  def show
  end

  # GET /course_problem_relations/new
  def new
    @course_problem_relation = CourseProblemRelation.new
  end

  # GET /course_problem_relations/1/edit
  def edit
  end

  # POST /course_problem_relations
  # POST /course_problem_relations.json
  def create
    @course_problem_relation = CourseProblemRelation.new(course_problem_relation_params)

    respond_to do |format|
      if @course_problem_relation.save
        format.html { redirect_to @course_problem_relation, notice: 'Course problem relation was successfully created.' }
        format.json { render :show, status: :created, location: @course_problem_relation }
      else
        format.html { render :new }
        format.json { render json: @course_problem_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_problem_relations/1
  # PATCH/PUT /course_problem_relations/1.json
  def update
    respond_to do |format|
      if @course_problem_relation.update(course_problem_relation_params)
        format.html { redirect_to @course_problem_relation, notice: 'Course problem relation was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_problem_relation }
      else
        format.html { render :edit }
        format.json { render json: @course_problem_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_problem_relations/1
  # DELETE /course_problem_relations/1.json
  def destroy
    @course_problem_relation.destroy
    respond_to do |format|
      format.html { redirect_to course_problem_relations_url, notice: 'Course problem relation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_problem_relation
      @course_problem_relation = CourseProblemRelation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_problem_relation_params
      params.require(:course_problem_relation).permit(:course, :problem)
    end
end
