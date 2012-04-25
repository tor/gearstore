class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.timestamps
			t.integer :amount
			t.integer :approver_id
      t.integer :rental_id
      t.integer :user_id

			t.string :description
    end
  end
end
