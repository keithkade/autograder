require 'test_helper'

class QuizMultipleChoiceQuestionsControllerTest < ActionController::TestCase
  setup do
    @quiz_multiple_choice_question = quiz_multiple_choice_questions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:quiz_multiple_choice_questions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create quiz_multiple_choice_question" do
    assert_difference('QuizMultipleChoiceQuestion.count') do
      post :create, quiz_multiple_choice_question: { answers: @quiz_multiple_choice_question.answers, correct_answer: @quiz_multiple_choice_question.correct_answer, question: @quiz_multiple_choice_question.question }
    end

    assert_redirected_to quiz_multiple_choice_question_path(assigns(:quiz_multiple_choice_question))
  end

  test "should show quiz_multiple_choice_question" do
    get :show, id: @quiz_multiple_choice_question
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @quiz_multiple_choice_question
    assert_response :success
  end

  test "should update quiz_multiple_choice_question" do
    patch :update, id: @quiz_multiple_choice_question, quiz_multiple_choice_question: { answers: @quiz_multiple_choice_question.answers, correct_answer: @quiz_multiple_choice_question.correct_answer, question: @quiz_multiple_choice_question.question }
    assert_redirected_to quiz_multiple_choice_question_path(assigns(:quiz_multiple_choice_question))
  end

  test "should destroy quiz_multiple_choice_question" do
    assert_difference('QuizMultipleChoiceQuestion.count', -1) do
      delete :destroy, id: @quiz_multiple_choice_question
    end

    assert_redirected_to quiz_multiple_choice_questions_path
  end
end
