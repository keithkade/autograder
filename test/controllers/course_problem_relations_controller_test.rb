require 'test_helper'

class CourseProblemRelationsControllerTest < ActionController::TestCase
  setup do
    @course_problem_relation = course_problem_relations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_problem_relations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_problem_relation" do
    assert_difference('CourseProblemRelation.count') do
      post :create, course_problem_relation: { course: @course_problem_relation.course, problem: @course_problem_relation.problem }
    end

    assert_redirected_to course_problem_relation_path(assigns(:course_problem_relation))
  end

  test "should show course_problem_relation" do
    get :show, id: @course_problem_relation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_problem_relation
    assert_response :success
  end

  test "should update course_problem_relation" do
    patch :update, id: @course_problem_relation, course_problem_relation: { course: @course_problem_relation.course, problem: @course_problem_relation.problem }
    assert_redirected_to course_problem_relation_path(assigns(:course_problem_relation))
  end

  test "should destroy course_problem_relation" do
    assert_difference('CourseProblemRelation.count', -1) do
      delete :destroy, id: @course_problem_relation
    end

    assert_redirected_to course_problem_relations_path
  end
end
