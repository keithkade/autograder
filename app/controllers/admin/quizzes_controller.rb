class Admin::QuizzesController < ApplicationController
  before_action :set_quiz, only: [:show, :edit, :update, :destroy]

  # GET /quizzes
  # GET /quizzes.json
  def index
    @quizzes = Quiz.order(:end_time)
    if params.include?(:courseid)
      session[:quiz_list_courseid] = params[:courseid]
    elsif session.include?(:quiz_list_courseid)
      redirect_to admin_quizzes_path(:courseid => session[:quiz_list_courseid])
    else
      redirect_to admin_quizzes_path(:courseid => -1)
    end
    
    @courseid = params[:courseid].to_i
    @courses = Course.unarchived.order(:name)
    if @courseid >= 0
    # Literally: Keep if the courseid is in the students' list of courses
      @quizzes = Array(@quizzes).keep_if { |quiz| quiz.courseid == @courseid }
    end
  end

  # GET /quizzes/1
  # GET /quizzes/1.json
  def show
    @course = Course.find_by_id(@quiz.courseid)

    @questions = QuizQuestion.where(:quizid => @quiz.id)
    @initial_qtype = QuizQuestion.question_types[0]
    
    # Builds a list of students with submissions
    # Not every student will have submitted a quiz, but we want to display all of
    # the students anyways.  Those missing a submission will be marked "danger"
    @students = @course.users.order(:LastName)
    @submissions = QuizSubmission.where(:quizid => @quiz.id)
    @student_submission = Hash.new
    @student_submission_status = Hash.new('danger')
    @submissions.each do |submission|
      @student_submission[submission.studentid] = submission
      if submission.graded?
        @student_submission_status[submission.studentid] = 'success'
      else
        @student_submission_status[submission.studentid] = 'info'
      end
    end
  end

  # GET /quizzes/new
  def new
    @quiz = Quiz.new
    @courses = Course.order(:name)
  end

  # GET /quizzes/1/edit
  def edit
    @courses = Course.order(:name)
  end

  # POST /quizzes
  # POST /quizzes.json
  def create
    @quiz = Quiz.new(quiz_params)

    respond_to do |format|
      if @quiz.save
        format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz was successfully created.' }
        format.json { render :show, status: :created, location: @quiz }
      else
        format.html { render :new }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /quizzes/1
  # PATCH/PUT /quizzes/1.json
  def update
    respond_to do |format|
      if @quiz.update(quiz_params)
        format.html { redirect_to admin_quiz_path(@quiz), notice: 'Quiz was successfully updated.' }
        format.json { render :show, status: :ok, location: @quiz }
      else
        format.html { render :edit }
        format.json { render json: @quiz.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /quizzes/1
  # DELETE /quizzes/1.json
  def destroy
  # Must destroy all associated questions also
    @questions = @quiz.questions
    @questions.each do |question|
      question.question.destroy
      question.destroy
    end
    @quiz.destroy
    respond_to do |format|
      format.html { redirect_to admin_quizzes_url, notice: 'Quiz was successfully destroyed.' }
      format.json { head :no_content }
    end
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
