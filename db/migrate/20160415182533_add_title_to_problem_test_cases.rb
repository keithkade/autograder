class AddTitleToProblemTestCases < ActiveRecord::Migration
  def change
    add_column :problem_test_cases, :title, :string
  end
end
