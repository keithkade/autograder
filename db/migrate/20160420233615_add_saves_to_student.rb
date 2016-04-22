class AddSavesToStudent < ActiveRecord::Migration
  def change
    add_column :students, :Saves, :string
  end
end
