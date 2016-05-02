class AddArchivedToStudents < ActiveRecord::Migration
  def change
    add_column :students, :is_archived, :boolean
  end
end
