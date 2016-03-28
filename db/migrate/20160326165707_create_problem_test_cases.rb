class CreateProblemTestCases < ActiveRecord::Migration
  def change
    create_table :problem_test_cases do |t|
      t.integer :problemid
      t.text :input
      t.text :output

      t.timestamps null: false
    end
  end
end
