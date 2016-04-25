class CreateQuizStudentAnswers < ActiveRecord::Migration
  def change
    create_table :quiz_student_answers do |t|
      t.integer :studentid
      t.integer :submissionid
      t.integer :questionid
      t.text :answer
      t.integer :points
      t.text :comments

      t.timestamps null: false
    end
  end
end
