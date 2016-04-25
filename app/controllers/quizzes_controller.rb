class QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show]

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.all
    student = Student.find_by_id(session[:user_id])
    quizzes = Quiz.where(:courseid => student.courses.map(&:id))
    
    submissions = QuizSubmission.where(:studentid => session[:user_id])
    @quizzes_to_take = Array(quizzes).clone.keep_if { |quiz| (not submissions.map { |submission| submission.quizid }.include?(quiz.id)) and (not Time.now > quiz.end_time) }
    
    @quizzes_submitted_or_missed = Array(quizzes).clone.keep_if { |quiz| not @quizzes_to_take.map { |quiz2| quiz2.id }.include?(quiz.id) }
    @submissions = Hash.new
    submissions.each do |submission|
      @submissions[submission.quizid] = submission
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz
      @quiz = Quiz.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_params
      params.require(:quiz).permit(:title, :courseid, :start_time, :end_time, :time_limit, :questions)
    end
end
