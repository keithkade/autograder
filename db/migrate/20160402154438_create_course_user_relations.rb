class CreateCourseUserRelations < ActiveRecord::Migration
  def change
    create_table :course_user_relations do |t|
      t.integer :course
      t.integer :user

      t.timestamps null: false
    end
  end
end
