class AddSortTypeGearItemType < ActiveRecord::Migration
  def up
    add_column :gear_item_types, :sort_type, :string, :default => 'alpha'
  end

  def down
    remove_column :gear_item_types, :sort_type
  end
end
