class CreateQuizzes < ActiveRecord::Migration
  def change
    create_table :quizzes do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.integer :time_limit
      t.text :questions

      t.timestamps null: false
    end
  end
end
