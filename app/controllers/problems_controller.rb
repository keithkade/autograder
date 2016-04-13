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
    # Prevents duplicates of problems from appearing.
      @problems.concat(Array(course.problems).keep_if { |prob| not @problems.map { |prob2| prob2.id }.include?(prob.id) })
    end
  end

  # GET /problems/1
  # GET /problems/1.json
  def show
    @problem_test_cases = ProblemTestCase.where(problemid: params[:id])
    @myid = params[:id]
  end

  # GET /problems/1/evaluate
  def evaluate
    result = eval_code(params[:code], params[:id])
    submission = Submission.create!(:code => params[:code], :studentid => session[:user_id], :problemid => params[:id], :result => result)
    submission.save
    render json: result, status: 200
  end
  
  def submission
    @submissions = Submission.where(:problem_id => @problem.id).where(:student_id => session[:user_id])
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
