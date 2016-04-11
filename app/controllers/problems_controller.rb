class ProblemsController < ApplicationController
  require 'open3'
  include ProblemsHelper
  
  before_action :set_problem, only: [:show, :edit, :update, :destroy]

  # GET /problems
  # GET /problems.json
  def index
    @student = Student.find(session[:user_id])
    courses = @student.courses
    for course in courses 
      @problems = course.problems
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem_test_cases = ProblemTestCase.where(problemid: params[:id])
    @myid = params[:id]
  end

  # GET /problems/1/evaluate ??
  def evaluate
    if params[:code] == 'good code'
      logger.info("GOT GOOD CODE")
      response = {
        status: "success",
        err: "",
        results: [
            {
                title: "test case #0",
                result: "success",
                err: "runtimeError: yadadada",
                input: "test case input 0"
            },
            {
                title: "test case #1",
                result: "fail",
                err: "",
                input: "test case input 1"
            },
            {
                title: "test case #2",
                result: "fail",
                err: "runtimeError: yadadada",
                input: "test case input 2"
            }
        ]
      }
    else
      logger.info("GOT BAD CODE")
      response = {
        status: "fail",
        err: "compile error: yadadada",
        results: []
      }
    end  
    result = eval_code(params[:code], params[:id])
    Submission.create!(:code => params[:code], :studentID => session[:user_id], :problemID => params[:id], :result => result)
  
    render json: result, status: 200
    
    eval_code(params[:code], params[:id])
    Submission.create!(:code => params[:code], :studentID => session[:user_id], :problemID => params[:id], :result => response)
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
