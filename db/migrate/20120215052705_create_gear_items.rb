class CreateGearItems < ActiveRecord::Migration
  def change
    create_table :gear_items do |t|
			t.integer :gear_item_type_id
			t.string :identifier
			t.string :description
			t.string :size
			t.string :value
			t.string :condition
			t.integer :year_purchased
			t.boolean :missing, :default => false
			t.boolean :rented, :default => false
			t.string :comment
			t.datetime :retired
      t.timestamps
    end
  end
end
