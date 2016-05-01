class Admin::QuizTypeQuestionsController < ApplicationController

  def new
    @quiz = Quiz.find_by_id(params[:quizid])
  end

  # GET /quiz_multiple_choice_questions/1/edit
  def edit
    @question_link = QuizQuestion.find_by_id(@question.questionid)
    @quiz = Quiz.find_by_id(@question_link.quizid)
  end

  # POST /quiz_multiple_choice_questions
  # POST /quiz_multiple_choice_questions.json
  def create
    respond_to do |format|
      if @question.save
        @question_link = QuizQuestion.create!(:qtype => params[:qtype], :qid => @question.id, :quizid => params[:quizid], :points => params[:points])
        @question_link.save
        @question.update(:questionid => @question_link.id)
        @quiz = Quiz.find_by_id(params[:quizid])
        format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz multiple choice question was successfully created.' }
        format.json { render :show, status: :created, location: @question }
      else
        format.html { render :new }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quiz_multiple_choice_questions/1
  # PATCH/PUT /quiz_multiple_choice_questions/1.json
  def update
    respond_to do |format|
      if @question.update(question_params)
        @question_link = QuizQuestion.find_by_id(@question.questionid)
        @question_link.update(:points => params[:points])
        @quiz = Quiz.find_by_id(@question_link.quizid)
        format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz multiple choice question was successfully updated.' }
        format.json { render :show, status: :ok, location: @question }
      else
        format.html { render :edit }
        format.json { render json: @question.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quiz_multiple_choice_questions/1
  # DELETE /quiz_multiple_choice_questions/1.json
  def destroy
    @question_link = QuizQuestion.find_by_id(@question.questionid)
    @quiz = Quiz.find_by_id(@question_link.quizid)
    @question_link.destroy
    @question.destroy
    respond_to do |format|
      format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz multiple choice question was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  protected
  def question_params
    {}
  end

end
