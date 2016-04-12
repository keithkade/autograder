class UpdateSubmissions < ActiveRecord::Migration
  def change
    add_column :submissions, :studentid, :integer
    add_column :submissions, :problemid, :integer
    change_column :submissions, :result, :text
    add_column :submissions, :timeSubmitted, :timestamp
    add_column :submissions, :status, :boolean
    remove_column :submissions, :response
    remove_column :submissions, :studentID
    remove_column :submissions, :problemID
  end
end
