class ProblemsController < ApplicationController
  require 'open3'
  include ProblemsHelper
  
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
    @student = Student.find(session[:user_id])
    courses = @student.courses
    @problems = []
    for course in courses 
      @problems.concat course.problems
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem_test_cases = ProblemTestCase.where(problemid: params[:id])
    @myid = params[:id]
  end

  # GET /problems/evaluate ??
  def evaluate
    result = eval_code(params[:code], params[:id])
    Submission.create!(:code => params[:code], :studentID => session[:user_id], :problemID => params[:id], :result => result)
    render json: result, status: 200
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_problem
      @problem = Problem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def problem_params
      params.require(:problem).permit(:title, :summary, :input_description, :output_description, :skeleton)
    end
end
