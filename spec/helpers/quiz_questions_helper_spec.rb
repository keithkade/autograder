require 'rails_helper'

describe QuizQuestionsHelper, :type => :helper do
  context "winnage" do
    before(:each) do
      @question = double("QuizQuestion", :id => 1)
    end
    
    it "should have the right edit path" do
      edit_quiz_question_of_type_path("thing", @question).should eq("/admin/quiz_thing_questions/1/edit")
    end
    
    it "should handle params correctly" do
      edit_quiz_question_of_type_path("thing", @question, :c => "good", :b => "bad").should eq("/admin/quiz_thing_questions/1/edit?c=good&b=bad")
    end
    
    it "should have the right path" do
      quiz_question_of_type_path("thing", @question).should eq("/admin/quiz_thing_questions/1")
    end
  end
end