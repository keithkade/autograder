class CourseUserRelationsController < ApplicationController
  before_action :set_course_user_relation, only: [:show, :edit, :update, :destroy]

  # GET /course_user_relations
  # GET /course_user_relations.json
  def index
    @course_user_relations = CourseUserRelation.all
  end

  # GET /course_user_relations/1
  # GET /course_user_relations/1.json
  def show
  end

  # GET /course_user_relations/new
  def new
    @course_user_relation = CourseUserRelation.new
  end

  # GET /course_user_relations/1/edit
  def edit
  end

  # POST /course_user_relations
  # POST /course_user_relations.json
  def create
    @course_user_relation = CourseUserRelation.new(course_user_relation_params)

    respond_to do |format|
      if @course_user_relation.save
        format.html { redirect_to @course_user_relation, notice: 'Course user relation was successfully created.' }
        format.json { render :show, status: :created, location: @course_user_relation }
      else
        format.html { render :new }
        format.json { render json: @course_user_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /course_user_relations/1
  # PATCH/PUT /course_user_relations/1.json
  def update
    respond_to do |format|
      if @course_user_relation.update(course_user_relation_params)
        format.html { redirect_to @course_user_relation, notice: 'Course user relation was successfully updated.' }
        format.json { render :show, status: :ok, location: @course_user_relation }
      else
        format.html { render :edit }
        format.json { render json: @course_user_relation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /course_user_relations/1
  # DELETE /course_user_relations/1.json
  def destroy
    @course_user_relation.destroy
    respond_to do |format|
      format.html { redirect_to course_user_relations_url, notice: 'Course user relation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_user_relation
      @course_user_relation = CourseUserRelation.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_user_relation_params
      params.require(:course_user_relation).permit(:course, :user)
    end
end
