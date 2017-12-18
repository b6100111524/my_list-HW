class CreateLists < ActiveRecord::Migration[5.1]
  def change
    create_table :lists do |t|
      t.string :title
      t.date :duedate
      t.text :note
      t.boolean :check_box
      t.timestamps
    end
  end
end
