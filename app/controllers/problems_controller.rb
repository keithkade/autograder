class ProblemsController < ApplicationController
  require 'open3'
  require 'pp'

  include ProblemsHelper
  
  before_action :set_problem, only: [:show, :edit, :update, :destroy, :load]

  # GET /problems
  # GET /problems.json
  def index
    @student = Student.find(session[:user_id])
    @problems = @student.problems
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

    status = true
    if result[:status] == 'fail'
      status = false
    elsif result[:status] == 'success'
      result[:results].each do |test_case|
        if test_case[:result] == "fail"
          status = false
        end
      end
    end

    submission = Submission.create!(:code => params[:code],
                                    :time_submitted => DateTime.strptime(params[:time_submitted],'%s'),
                                    :page_loaded_at => DateTime.strptime(params[:page_loaded_at],'%s'),
                                    :student_id => session[:user_id],
                                    :problem_id => params[:id],
                                    :result => result.to_json,
                                    :status => status)

    submission.save
    render json: result, status: 200
  end

  # POST /problems/1/save
  def save
    student = Student.find(session[:user_id])
    saves = student.Saves
    if not saves
      student.Saves = {params[:id] => params[:code]}.to_json
    else
      savesHash = JSON.parse(student.Saves)
      savesHash[params[:id]] = params[:code]
      student.Saves = savesHash.to_json
    end
    student.save

    render json: {'status':'Save Successful'}, status: 200
  end

  # GET /problems/1/load
  def load
    code = @problem.skeleton
    if Student.find(session[:user_id]).Saves
      saves = JSON.parse(Student.find(session[:user_id]).Saves)
      if saves.key?(params[:id])
        code = saves[params[:id]]
        end
    end
    render json: {'code': code}, status: 200
  end

  def submissions
    set_problem
    @submissions = Submission.order('time_submitted DESC')
                             .where(:problem_id => params[:id])
                             .where(:student_id => session[:user_id])
                             
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
