class CreateQuizQuestions < ActiveRecord::Migration
  def change
    create_table :quiz_questions do |t|
      t.string :qtype
      t.integer :qid

      t.timestamps null: false
    end
  end
end
