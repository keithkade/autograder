class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :Name
      t.string :ID
      t.string :UserName
      t.string :Password
      t.string :Class

      t.timestamps null: false
    end
  end
end
