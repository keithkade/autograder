class ProblemTestCasesController < ApplicationController
  before_action :set_problem_test_case, only: [:show, :edit, :update, :destroy]

  # GET /problem_test_cases
  # GET /problem_test_cases.json
  def index
    @problem_test_cases = ProblemTestCase.all
    redirect_to problems_path
  end

  # GET /problem_test_cases/1
  # GET /problem_test_cases/1.json
  def show
    redirect_to problems_path
  end

  # GET /problem_test_cases/new
  def new
    @problem_test_case = ProblemTestCase.new(:problemid => params[:problemid])
    @problem = Problem.find(@problem_test_case.problemid)
  end

  # GET /problem_test_cases/1/edit
  def edit
    @problem_test_case = ProblemTestCase.find(params[:id])
    @problem = Problem.find(@problem_test_case.problemid)
  end

  # POST /problem_test_cases
  # POST /problem_test_cases.json
  def create
    @problem_test_case = ProblemTestCase.new(problem_test_case_params)
    @problem = Problem.find(problem_test_case_params[:problemid])

    respond_to do |format|
      if @problem_test_case.save
        format.html { redirect_to problem_path(@problem), notice: 'Problem test case was successfully created.' }
        format.json { render :show, status: :created, location: @problem_test_case }
      else
        format.html { render :new }
        format.json { render json: @problem_test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /problem_test_cases/1
  # PATCH/PUT /problem_test_cases/1.json
  def update
    @problem = Problem.find(problem_test_case_params[:problemid])
    respond_to do |format|
      if @problem_test_case.update(problem_test_case_params)
        format.html { redirect_to problem_path(@problem), notice: 'Problem test case was successfully updated.' }
        format.json { render :show, status: :ok, location: @problem_test_case }
      else
        format.html { render :edit }
        format.json { render json: @problem_test_case.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /problem_test_cases/1
  # DELETE /problem_test_cases/1.json
  def destroy
    @problem = @problem_test_case.problemid
    @problem_test_case.destroy
    respond_to do |format|
      format.html { redirect_to problem_path(@problem), notice: 'Problem test case was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem_test_case
      @problem_test_case = ProblemTestCase.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_test_case_params
      params.require(:problem_test_case).permit(:problemid, :input, :output)
    end
end
