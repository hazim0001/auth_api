class CreateNotes < ActiveRecord::Migration[6.1]
  def change
    create_table :notes do |t|
      t.string :name
      t.text :description
      t.integer :quantity
      t.datetime :due_date

      t.timestamps
    end
  end
end
