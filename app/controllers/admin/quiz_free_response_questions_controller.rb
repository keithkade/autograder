class Admin::QuizFreeResponseQuestionsController < Admin::QuizTypeQuestionsController
  before_action :set_quiz_free_response_question, only: [:show, :edit, :update, :destroy]

  # GET /quiz_free_response_questions/new
  def new
    @question = QuizFreeResponseQuestion.new
    super
  end

  # POST /quiz_free_response_questions
  # POST /quiz_free_response_questions.json
  def create
    @question = QuizFreeResponseQuestion.new(question_params)
    super
  end
  
  protected
  def question_params
    params.require(:quiz_free_response_question).permit(:correct_answer, :question)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_free_response_question
      @question = QuizFreeResponseQuestion.find(params[:id])
    end
end
