class Admin::QuizMultipleChoiceQuestionsController < ApplicationController
  before_action :set_quiz_multiple_choice_question, only: [:show, :edit, :update, :destroy]

  # GET /quiz_multiple_choice_questions
  # GET /quiz_multiple_choice_questions.json
  def index
    @quiz_multiple_choice_questions = QuizMultipleChoiceQuestion.all
  end

  # GET /quiz_multiple_choice_questions/1
  # GET /quiz_multiple_choice_questions/1.json
  def show
  end

  # GET /quiz_multiple_choice_questions/new
  def new
    @quiz_multiple_choice_question = QuizMultipleChoiceQuestion.new
  end

  # GET /quiz_multiple_choice_questions/1/edit
  def edit
  end

  # POST /quiz_multiple_choice_questions
  # POST /quiz_multiple_choice_questions.json
  def create
    @quiz_multiple_choice_question = QuizMultipleChoiceQuestion.new(quiz_multiple_choice_question_params)

    respond_to do |format|
      if @quiz_multiple_choice_question.save
        format.html { redirect_to @quiz_multiple_choice_question, notice: 'Quiz multiple choice question was successfully created.' }
        format.json { render :show, status: :created, location: @quiz_multiple_choice_question }
      else
        format.html { render :new }
        format.json { render json: @quiz_multiple_choice_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quiz_multiple_choice_questions/1
  # PATCH/PUT /quiz_multiple_choice_questions/1.json
  def update
    respond_to do |format|
      if @quiz_multiple_choice_question.update(quiz_multiple_choice_question_params)
        format.html { redirect_to @quiz_multiple_choice_question, notice: 'Quiz multiple choice question was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz_multiple_choice_question }
      else
        format.html { render :edit }
        format.json { render json: @quiz_multiple_choice_question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_multiple_choice_questions/1
  # DELETE /quiz_multiple_choice_questions/1.json
  def destroy
    @quiz_multiple_choice_question.destroy
    respond_to do |format|
      format.html { redirect_to quiz_multiple_choice_questions_url, notice: 'Quiz multiple choice question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_multiple_choice_question
      @quiz_multiple_choice_question = QuizMultipleChoiceQuestion.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_multiple_choice_question_params
      params.require(:quiz_multiple_choice_question).permit(:question, :answers, :correct_answer)
    end
end
