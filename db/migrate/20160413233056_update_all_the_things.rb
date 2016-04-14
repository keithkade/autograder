class UpdateAllTheThings < ActiveRecord::Migration
  def change
    add_column :courses, :semester, :string
    add_column :courses, :year, :integer
    add_column :courses, :is_archived, :boolean
    
    add_column :students, :LastName, :string
    remove_column :students, :Name
    add_column :students, :FirstName, :string
    remove_column :students, :Class
  end
end
