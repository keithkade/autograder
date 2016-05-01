class CreateQuizSubmissions < ActiveRecord::Migration
  def change
    create_table :quiz_submissions do |t|
      t.integer :studentid
      t.integer :quizid
      t.integer :time_taken

      t.timestamps
    end
  end
end
