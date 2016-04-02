class CreateCourseProblemRelations < ActiveRecord::Migration
  def change
    create_table :course_problem_relations do |t|
      t.integer :course
      t.integer :problem

      t.timestamps null: false
    end
  end
end
