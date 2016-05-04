require 'rails_helper'

describe Admin::CoursesController do

  let!(:course) { Course.new }

  before :each do
    controller.stub(:logged_in_admin?).and_return(true)
    Course.stub(:find).and_return(course)
    Course.stub(:new).and_return(course)
  end

  describe 'Courses controller spec' do

    context "update with invalid attributes" do
      it  "should render edit again on bad input for new class" do
        course.stub(:update).and_return(false)
        put :update, :id => 1, :course => {:name => 'test'}
        response.should render_template(:edit)
      end
    end

    context "creation with invalid attributes" do
      it "does not create the vehicle" do
        count = Course.count
        course.stub(:save).and_return(false)
        post :create, :course => {:name => 'test'}
        expect(Course.count).to eq(count)
      end

      it  "should render new again on bad input for new class" do
        course.stub(:save).and_return(false)
        post :create, :course => {:name => 'test'}
        response.should render_template(:new)
      end
    end

    context "download" do
      it "downloads" do
        
      end
    end
  end

end
