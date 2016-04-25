require 'rails_helper'

describe Admin::ProblemsController do

  let!(:problem) { Problem.new }

  before :each do
    controller.stub(:logged_in_admin?).and_return(true)
    Problem.stub(:find).and_return(problem)
    Problem.stub(:new).and_return(problem)
  end

  describe 'Courses controller spec' do

    context "update with invalid attributes" do
      it  "should render edit again on bad input for new class" do
        problem.stub(:update).and_return(false)
        put :update, :id => 1, :problem => {:name => 'test'}
        response.should render_template(:edit)
      end
    end

    context "creation with invalid attributes" do
      it "does not create the vehicle" do
        count = Problem.count
        problem.stub(:save).and_return(false)
        post :create, :problem => {:name => 'test'}
        expect(Problem.count).to eq(count)
      end

      it  "should render new again on bad input for new class" do
        problem.stub(:save).and_return(false)
        post :create, :problem => {:name => 'test'}
        response.should render_template(:new)
      end
    end

  end
end
