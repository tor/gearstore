class AddUserNotesApprover < ActiveRecord::Migration
  def up
    add_column :user_notes, :approver_id, :integer 
  end

  def down
    remove_column :user_notes, :approver_id
  end
end
