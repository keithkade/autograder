require 'spec_helper'

describe QuizSubmission do
  context "findjunk" do
    before(:each) do
      @quiz_submission = QuizSubmission.create!(:studentid => 1, :quizid => 1)
      @fake_student = double("Student", :id => 1)
      @fake_quiz = double("Quiz", :id => 1)
      @fake_a1 = double("QuizStudentAnswer", :id => 1, :submissionid => 1)
      @fake_a2 = double("QuizStudentAnswer", :id => 2, :submissionid => 1)
      @fake_a3 = double("QuizStudentAnswer", :id => 3, :submissionid => 2)
      Student.stub(:find_by_id).with(1).and_return(@fake_student)
      Quiz.stub(:find_by_id).with(1).and_return(@fake_quiz)
      QuizStudentAnswer.stub(:where).with(:submissionid => 1).and_return([@fake_a1, @fake_a2])
    end
    
    it "should find the right student" do
      @quiz_submission.student.should eq(@fake_student)
    end
    
    it "should find the right quiz" do
      @quiz_submission.quiz.should eq(@fake_quiz)
    end
    
    it "should find the right answers" do
      @quiz_submission.answers.should eq([@fake_a1, @fake_a2])
    end
  end
  
  context "grade" do
    before(:each) do
      @quiz_submission = QuizSubmission.create!
      @fake_a1 = double("QuizStudentAnswer", :id => 1, :submissionid => 1, :points => 3)
      @fake_a2 = double("QuizStudentAnswer", :id => 2, :submissionid => 1, :points => 5)
      @fake_a3 = double("QuizStudentAnswer", :id => 3, :submissionid => 2, :points => 7)
      @quiz = double("Quiz", :id => 1)
      @quiz.stub(:points_possible).and_return(10)
      @fake_a1.stub(:graded?).and_return(true)
      @fake_a2.stub(:graded?).and_return(true)
      @fake_a3.stub(:graded?).and_return(true)
      @quiz_submission.stub(:answers).and_return([@fake_a1, @fake_a2])
      @quiz_submission.stub(:quiz).and_return(@quiz)
    end
    
    it "should return the right sum of points" do
      @quiz_submission.points.should eq(8)
    end
    
    it "should return the right grade ratio" do
      @quiz_submission.raw_score.should eq("8 / 10")
    end
    
    it "should return the correct score" do
      @quiz_submission.score.should eq(80)
    end
  end
end