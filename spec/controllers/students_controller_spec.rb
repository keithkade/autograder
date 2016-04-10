require 'rails_helper'

describe Admin::StudentsController do

  let!(:student) { Student.new }

  before :each do
    controller.stub(:logged_in_admin?).and_return(true)
    Student.stub(:new).and_return(student)
  end

  describe 'Students Controller spec' do

    context "update with invalid attributes" do
      it  "should render edit again on bad input for new class" do
        student.stub(:update).and_return(false)
        put :update, :id => 1, :student => {:name => 'test'}
        response.should render_template(:edit)
      end
    end

    context "creation with invalid attributes" do
      it "does not create the vehicle" do
        count = Student.count
        student.stub(:save).and_return(false)
        post :create, :student => {:name => 'test'}
        expect(Student.count).to eq(count)
      end

      it  "should render new again on bad input for new class" do
        student.stub(:save).and_return(false)
        post :create, :student => {:name => 'test'}
        response.should render_template(:new)
      end
    end

  end
end