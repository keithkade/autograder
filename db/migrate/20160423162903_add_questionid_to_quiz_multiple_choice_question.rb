class AddQuestionidToQuizMultipleChoiceQuestion < ActiveRecord::Migration
  def change
    add_column :quiz_multiple_choice_questions, :questionid, :integer
  end
end
