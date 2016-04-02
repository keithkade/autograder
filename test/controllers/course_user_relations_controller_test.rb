require 'test_helper'

class CourseUserRelationsControllerTest < ActionController::TestCase
  setup do
    @course_user_relation = course_user_relations(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:course_user_relations)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create course_user_relation" do
    assert_difference('CourseUserRelation.count') do
      post :create, course_user_relation: { course: @course_user_relation.course, user: @course_user_relation.user }
    end

    assert_redirected_to course_user_relation_path(assigns(:course_user_relation))
  end

  test "should show course_user_relation" do
    get :show, id: @course_user_relation
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @course_user_relation
    assert_response :success
  end

  test "should update course_user_relation" do
    patch :update, id: @course_user_relation, course_user_relation: { course: @course_user_relation.course, user: @course_user_relation.user }
    assert_redirected_to course_user_relation_path(assigns(:course_user_relation))
  end

  test "should destroy course_user_relation" do
    assert_difference('CourseUserRelation.count', -1) do
      delete :destroy, id: @course_user_relation
    end

    assert_redirected_to course_user_relations_path
  end
end
