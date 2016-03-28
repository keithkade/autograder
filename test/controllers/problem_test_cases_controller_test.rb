require 'test_helper'

class ProblemTestCasesControllerTest < ActionController::TestCase
  setup do
    @problem_test_case = problem_test_cases(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:problem_test_cases)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create problem_test_case" do
    assert_difference('ProblemTestCase.count') do
      post :create, problem_test_case: { input: @problem_test_case.input, output: @problem_test_case.output, problemid: @problem_test_case.problemid }
    end

    assert_redirected_to problem_test_case_path(assigns(:problem_test_case))
  end

  test "should show problem_test_case" do
    get :show, id: @problem_test_case
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @problem_test_case
    assert_response :success
  end

  test "should update problem_test_case" do
    patch :update, id: @problem_test_case, problem_test_case: { input: @problem_test_case.input, output: @problem_test_case.output, problemid: @problem_test_case.problemid }
    assert_redirected_to problem_test_case_path(assigns(:problem_test_case))
  end

  test "should destroy problem_test_case" do
    assert_difference('ProblemTestCase.count', -1) do
      delete :destroy, id: @problem_test_case
    end

    assert_redirected_to problem_test_cases_path
  end
end
