require 'test_helper'

class QuizSubmissionsControllerTest < ActionController::TestCase
  setup do
    @quiz_submission = quiz_submissions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiz_submissions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz_submission" do
    assert_difference('QuizSubmission.count') do
      post :create, quiz_submission: { quizid: @quiz_submission.quizid, studentid: @quiz_submission.studentid, time_taken: @quiz_submission.time_taken }
    end

    assert_redirected_to quiz_submission_path(assigns(:quiz_submission))
  end

  test "should show quiz_submission" do
    get :show, id: @quiz_submission
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiz_submission
    assert_response :success
  end

  test "should update quiz_submission" do
    patch :update, id: @quiz_submission, quiz_submission: { quizid: @quiz_submission.quizid, studentid: @quiz_submission.studentid, time_taken: @quiz_submission.time_taken }
    assert_redirected_to quiz_submission_path(assigns(:quiz_submission))
  end

  test "should destroy quiz_submission" do
    assert_difference('QuizSubmission.count', -1) do
      delete :destroy, id: @quiz_submission
    end

    assert_redirected_to quiz_submissions_path
  end
end
