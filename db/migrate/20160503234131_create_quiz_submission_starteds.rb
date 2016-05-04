class CreateQuizSubmissionStarteds < ActiveRecord::Migration
  def change
    create_table :quiz_submission_starteds do |t|
      t.integer :studentid
      t.integer :quizid

      t.timestamps null: false
    end
  end
end
