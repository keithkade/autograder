require 'test_helper'

class QuizFreeResponseQuestionsControllerTest < ActionController::TestCase
  setup do
    @quiz_free_response_question = quiz_free_response_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiz_free_response_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz_free_response_question" do
    assert_difference('QuizFreeResponseQuestion.count') do
      post :create, quiz_free_response_question: { correct_answer: @quiz_free_response_question.correct_answer, question: @quiz_free_response_question.question }
    end

    assert_redirected_to quiz_free_response_question_path(assigns(:quiz_free_response_question))
  end

  test "should show quiz_free_response_question" do
    get :show, id: @quiz_free_response_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiz_free_response_question
    assert_response :success
  end

  test "should update quiz_free_response_question" do
    patch :update, id: @quiz_free_response_question, quiz_free_response_question: { correct_answer: @quiz_free_response_question.correct_answer, question: @quiz_free_response_question.question }
    assert_redirected_to quiz_free_response_question_path(assigns(:quiz_free_response_question))
  end

  test "should destroy quiz_free_response_question" do
    assert_difference('QuizFreeResponseQuestion.count', -1) do
      delete :destroy, id: @quiz_free_response_question
    end

    assert_redirected_to quiz_free_response_questions_path
  end
end
