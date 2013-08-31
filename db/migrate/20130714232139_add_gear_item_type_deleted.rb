class AddGearItemTypeDeleted < ActiveRecord::Migration
  def up
    add_column :gear_item_types, :deleted, :bool, :default => false
  end

  def down
    remove_column :gear_item_types, :deleted
  end
end
