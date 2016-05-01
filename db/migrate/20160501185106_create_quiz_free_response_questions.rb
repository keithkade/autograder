class CreateQuizFreeResponseQuestions < ActiveRecord::Migration
  def change
    create_table :quiz_free_response_questions do |t|
      t.text :correct_answer
      t.text :question

      t.timestamps null: false
    end
  end
end
