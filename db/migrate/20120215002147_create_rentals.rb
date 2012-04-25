class CreateRentals < ActiveRecord::Migration
  def change
    create_table :rentals do |t|
			t.integer   :user_id	
			t.datetime  :return_on
			t.datetime  :rented_on
			t.integer   :approver_id
			t.integer   :fee, :default => 0
			t.integer   :deposit, :default => 0
      t.string    :note
      t.timestamps
    end
  end
end
