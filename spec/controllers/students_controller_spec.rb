require 'rails_helper'

describe StudentsController do

  before :each do
    @student = students(:one)
  end

  describe 'Students Controller' do

    it "should get index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:students)
    end

    it "should get new" do
      get :new
      assert_response :success
    end

    it "should create student" do
      assert_difference('Student.count') do
        post :create, student: { Class: @student.Class, ID: @student.ID, Name: @student.Name, Password: @student.Password, UserName: @student.UserName }
      end

      assert_redirected_to student_path(assigns(:student))
    end

    it "should show student" do
      get :show, id: @student
      assert_response :success
    end

    it "should get edit" do
      get :edit, id: @student
      assert_response :success
    end

    it "should update student" do
      patch :update, id: @student, student: { Class: @student.Class, ID: @student.ID, Name: @student.Name, Password: @student.Password, UserName: @student.UserName }
      assert_redirected_to student_path(assigns(:student))
    end

    it "should destroy student" do
      assert_difference('Student.count', -1) do
        delete :destroy, id: @student
      end

      assert_redirected_to students_path
    end

  end
end
