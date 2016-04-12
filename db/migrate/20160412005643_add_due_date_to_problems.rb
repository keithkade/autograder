class AddDueDateToProblems < ActiveRecord::Migration
  def up
    add_column :problems, :due_date, :datetime
  end

  def down
    remove_column :problems, :due_date
  end
end
