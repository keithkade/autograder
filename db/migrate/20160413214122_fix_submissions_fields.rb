class FixSubmissionsFields < ActiveRecord::Migration
  def change
    remove_column :submissions, :timeOnPage
    remove_column :submissions, :studentid
    remove_column :submissions, :problemid
    remove_column :submissions, :timeSubmitted
    add_column :submissions, :page_loaded_at, :timestamp
    add_column :submissions, :time_submitted, :timestamp
    add_column :submissions, :problem_id, :integer
    add_column :submissions, :student_id, :integer
  end
end
