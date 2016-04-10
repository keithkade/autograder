class CreateSubmissions < ActiveRecord::Migration
  def change
    create_table :submissions do |t|
      t.string :studentID
      t.string :problemID
      t.text :code
      t.integer :timeOnPage
      t.string :response

      t.timestamps null: false
    end
  end
end
