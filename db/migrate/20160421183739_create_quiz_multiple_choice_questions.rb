class CreateQuizMultipleChoiceQuestions < ActiveRecord::Migration
  def change
    create_table :quiz_multiple_choice_questions do |t|
      t.text :question
      t.text :answers
      t.integer :correct_answer

      t.timestamps null: false
    end
  end
end
