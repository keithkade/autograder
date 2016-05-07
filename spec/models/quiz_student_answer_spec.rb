require 'spec_helper'

describe QuizStudentAnswer do
  context "findjunk" do
    before(:each) do
      @answer = QuizStudentAnswer.create!(:questionid => 1)
      @fake_question = double("QuizQuestion", :id => 1)
      QuizQuestion.stub(:find_by_id).with(1).and_return(@fake_question)
    end
    
    it "should find the right question" do
      @answer.question.should eq(@fake_question)
    end
  end
  
  context "score" do
    before(:each) do
      @answer = QuizStudentAnswer.create!(:points => 3)
      @question = double("QuizQuestion", :id => 1, :points => 5)
    end
    
    it "should be 3/5" do
      @answer.raw_score.should eq("3 / 5")
    end
  end
  
  context "status" do
    before(:each) do
      @answer_right = QuizStudentAnswer.create!(:points => 5)
      @answer_partial = QuizStudentAnswer.create!(:points => 3)
      @answer_wrong = QuizStudentAnswer.create!(:points => 0)
      @answer_nil   = QuizStudentAnswer.create!
      @question = double("QuizQuestion", :id => 1, :points => 5)
      @answer_right.stub(:question).and_return(@question)
      @answer_partial.stub(:question).and_return(@question)
      @answer_wrong.stub(:question).and_return(@question)
      @answer_nil.stub(:question).and_return(@question)
    end
    
    it "should have correct correctness" do
      @answer_right.correct?.should eq(true)
      @answer_partial.correct?.should eq(false)
      @answer_wrong.correct?.should eq(false)
    end
    
    it "should have correct correctness" do
      @answer_right.partial?.should eq(false)
      @answer_partial.partial?.should eq(true)
      @answer_wrong.partial?.should eq(false)
    end
    
    it "should have correct correctness" do
      @answer_right.incorrect?.should eq(false)
      @answer_partial.incorrect?.should eq(false)
      @answer_wrong.incorrect?.should eq(true)
    end
    
    it "should have right status" do
      @answer_right.status_css_class.should eq("success")
      @answer_partial.status_css_class.should eq("warning")
      @answer_wrong.status_css_class.should eq("danger")
      @answer_nil.status_css_class.should eq("info")
    end
  end
end