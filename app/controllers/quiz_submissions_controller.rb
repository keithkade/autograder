class QuizSubmissionsController < ApplicationController
  before_action :set_quiz_submission, only: [:show, :edit, :update, :destroy]

  # GET /quiz_submissions
  # GET /quiz_submissions.json
  def index
    kick_student_out_of_page
    @quiz_submissions = []
  end

  # GET /quiz_submissions/1
  # GET /quiz_submissions/1.json
  def show
    kick_if_wrong_student(@quiz_submission.studentid)
    @quiz = Quiz.find_by_id(@quiz_submission.quizid)
    @questions = QuizQuestion.where(:quizid => @quiz.id)
    @answers = Hash.new
    @questions.each do |question|
      @answers[question.id] = QuizStudentAnswer.where(:questionid => question.id).where(:studentid => session[:user_id]).first
    end
  end

  # GET /quiz_submissions/new
  def new
    if QuizSubmissionStarted.started?(params[:quizid], session[:user_id])
      kick_student_out_of_page
    else
      QuizSubmissionStarted.create!(:quizid => params[:quizid], :studentid => session[:user_id]).save
    end
    @quiz_submission = QuizSubmission.new
    @student = Student.find_by_id(session[:user_id])
    @quiz = Quiz.find_by_id(params[:quizid])
    @questions = QuizQuestion.where(:quizid => @quiz.id)
  end

  # GET /quiz_submissions/1/edit
  def edit
    kick_student_out_of_page
  end

  # POST /quiz_submissions
  # POST /quiz_submissions.json
  def create
    @quiz_submission = QuizSubmission.new(quiz_submission_params)

    respond_to do |format|
      if @quiz_submission.save
        
        questions = QuizQuestion.where(:quizid => @quiz_submission.quizid)
        questions.each do |question|
          answer_params = {
            :studentid => @quiz_submission.studentid,
            :submissionid => @quiz_submission.id,
            :questionid => question.id,
            :answer => params["question_#{question.id}"]
          }
          
          if question.question.automatic?
            if answer_params[:answer] == question.question.correct_answer
              answer_params[:points] = question.points
            else
              answer_params[:points] = 0
            end
          end
          
          answer = QuizStudentAnswer.create!(answer_params)
          answer.save
        end
        
        format.html { redirect_to @quiz_submission, notice: 'Quiz submission was successfully created.' }
        format.json { render :show, status: :created, location: @quiz_submission }
      else
        format.html { render :new }
        format.json { render json: @quiz_submission.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quiz_submissions/1
  # PATCH/PUT /quiz_submissions/1.json
  def update
    #kick_student_out_of_page
   #
   # respond_to do |format|
   #   if @quiz_submission.update(quiz_submission_params)
   #     format.html { redirect_to @quiz_submission, notice: 'Quiz submission was successfully updated.' }
   #     format.json { render :show, status: :ok, location: @quiz_submission }
   #   else
   #     format.html { render :edit }
   #     format.json { render json: @quiz_submission.errors, status: :unprocessable_entity }
   #   end
   # end
  end

  # DELETE /quiz_submissions/1
  # DELETE /quiz_submissions/1.json
  def destroy
    #if not logged_in_admin?
    #  redirect_to '/'
    #end
    #@quiz_submission.destroy
    #respond_to do |format|
    #  format.html { redirect_to quiz_submissions_url, notice: 'Quiz submission was successfully destroyed.' }
    #  format.json { head :no_content }
    #end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_quiz_submission
      @quiz_submission = QuizSubmission.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def quiz_submission_params
      params.require(:quiz_submission).permit(:studentid, :quizid, :time_taken)
    end
    
    def kick_student_out_of_page
      redirect_to quizzes_path
    end
    
    def kick_if_wrong_student(student_id)
      if logged_in_student? and student_id != session[:user_id]
        kick_student_out_of_page
      end
    end
end
