class CreateRentalItems < ActiveRecord::Migration
  def change
    create_table :rental_items do |t|
			t.integer :rental_id
			t.integer :gear_item_id
			t.integer :return_approver_id
			t.string :return_note
			t.datetime :returned_on
			t.boolean :missing
			t.integer :fee
			t.integer :deposit
      t.timestamps
    end
  end
end
