class AddGradesToStudents < ActiveRecord::Migration
  def change
    add_column :students, :Quizs_grade, :string
    add_column :students, :Problems_grade, :string
    add_column :students, :lateProblemsGrade, :string
  end
end
