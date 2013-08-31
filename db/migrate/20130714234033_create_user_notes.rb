class CreateUserNotes < ActiveRecord::Migration
  def change
    create_table :user_notes do |t|
      t.integer :user_id
      t.string :note
      t.timestamps
    end
  end
end
