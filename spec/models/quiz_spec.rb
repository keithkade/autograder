require 'spec_helper'

describe Quiz do
  context "points" do
    before(:each) do
      @quiz = Quiz.create!
      @fake_q1 = double('QuizQuestion', :id => 1, :points => 5)
      @fake_q2 = double('QuizQuestion', :id => 2, :points => 2)
      @quiz.stub(:questions).and_return([@fake_q1, @fake_q2])
    end
    
    it "should return the correct number of possible points from questions" do
      @quiz.points_possible.should eq(7)
    end
  end
end