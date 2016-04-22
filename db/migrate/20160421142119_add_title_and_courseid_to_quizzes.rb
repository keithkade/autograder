class AddTitleAndCourseidToQuizzes < ActiveRecord::Migration
  def change
    add_column :quizzes, :title, :string
    add_column :quizzes, :courseid, :integer
  end
end
