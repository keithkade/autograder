class FixProblemsMigration < ActiveRecord::Migration
  def change
    remove_column :problems, :body
    add_column :problems, :summary, :text
    add_column :problems, :input_description, :text
    add_column :problems, :output_description, :text
    change_column :problems, :skeleton, :text
  end
end
