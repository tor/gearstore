class CreateGearItemTypes < ActiveRecord::Migration
  def change
    create_table :gear_item_types do |t|
			t.string :name
      t.timestamps
			t.integer :private_hire, :default => 0
			t.integer :private_deposit, :default => 0
			t.integer :club_hire, :default => 0
			t.integer :club_deposit, :default => 0
    end
  end
end
