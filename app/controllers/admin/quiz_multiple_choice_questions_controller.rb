class Admin::QuizMultipleChoiceQuestionsController < Admin::QuizTypeQuestionsController
  before_action :set_quiz_multiple_choice_question, only: [:show, :edit, :update, :destroy]

  # GET /quiz_multiple_choice_questions/new
  def new
    @question = QuizMultipleChoiceQuestion.new
    super
  end

  # POST /quiz_multiple_choice_questions
  # POST /quiz_multiple_choice_questions.json
  def create
    @question = QuizMultipleChoiceQuestion.new(question_params)
    super
  end

  protected
  def question_params
    params.require(:quiz_multiple_choice_question).permit(:question, :answer_A, :answer_B, :answer_C, :answer_D, :answer_E, :correct_answer)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_multiple_choice_question
      @question = QuizMultipleChoiceQuestion.find(params[:id])
    end
end
