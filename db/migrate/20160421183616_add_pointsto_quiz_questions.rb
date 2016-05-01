class AddPointstoQuizQuestions < ActiveRecord::Migration
  def change
    add_column :quiz_questions, :points, :integer
  end
end
