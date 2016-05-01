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
    @question = QuizMultipleChoiceQuestion.new
    @quiz = Quiz.find_by_id(params[:quizid])
  end

  # GET /quiz_multiple_choice_questions/1/edit
  def edit
    @question = @quiz_multiple_choice_question
    @question_link = QuizQuestion.find_by_id(@question.questionid)
    @quiz = Quiz.find_by_id(@question_link.quizid)
  end

  # POST /quiz_multiple_choice_questions
  # POST /quiz_multiple_choice_questions.json
  def create
    @quiz_multiple_choice_question = QuizMultipleChoiceQuestion.new(quiz_multiple_choice_question_params)

    respond_to do |format|
      if @quiz_multiple_choice_question.save
        @question_link = QuizQuestion.create!(:qtype => params[:qtype], :qid => @quiz_multiple_choice_question.id, :quizid => params[:quizid], :points => params[:points])
        @question_link.save
        @quiz_multiple_choice_question.update(:questionid => @question_link.id)
        @quiz = Quiz.find_by_id(params[:quizid])
        format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz multiple choice question was successfully created.' }
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
        @question_link = QuizQuestion.find_by_id(@quiz_multiple_choice_question.questionid)
        @question_link.update(:points => params[:points])
        @quiz = Quiz.find_by_id(@question_link.quizid)
        format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz multiple choice question was successfully updated.' }
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
    @question_link = QuizQuestion.find_by_id(@quiz_multiple_choice_question.questionid)
    @quiz = Quiz.find_by_id(@question_link.quizid)
    @question_link.destroy
    @quiz_multiple_choice_question.destroy
    respond_to do |format|
      format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz multiple choice question was successfully destroyed.' }
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
      params.require(:quiz_multiple_choice_question).permit(:question, :answer_A, :answer_B, :answer_C, :answer_D, :answer_E, :correct_answer)
    end
end
