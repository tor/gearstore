class CreateGearItemNotes < ActiveRecord::Migration
  def change
    create_table :gear_item_notes do |t|
      t.integer :rental_item_id
      t.integer :approver_id
      t.integer :gear_item_id
      t.string :note
      t.timestamps
    end
  end
end
