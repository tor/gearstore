class AddBroken < ActiveRecord::Migration
  def up
    add_column :gear_items, :broken, :boolean, :default => false
  end

  def down
    remove_column :gear_items, :broken
  end
end
