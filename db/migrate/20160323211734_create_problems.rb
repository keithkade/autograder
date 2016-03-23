class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :title
      t.string :body
      t.string :skeleton

      t.timestamps null: false
    end
  end
end
