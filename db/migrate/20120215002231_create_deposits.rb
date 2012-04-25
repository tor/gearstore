class CreateDeposits < ActiveRecord::Migration
  def change
    create_table :deposits do |t|
			t.integer :amount, :default => 0
			t.integer :user_id
      t.timestamps
    end
  end
end
