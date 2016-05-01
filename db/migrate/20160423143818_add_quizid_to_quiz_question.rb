class AddQuizidToQuizQuestion < ActiveRecord::Migration
  def change
    add_column :quiz_questions, :quizid, :integer
  end
end
