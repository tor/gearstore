class RentalItem < ActiveRecord::Base
	belongs_to :rental
	belongs_to :gear_item
	has_one :gear_item_note

	before_create :set_rented
	after_update :set_rented
	
	def return_approver
		User.find(return_approver_id)
	end

	def set_rented
		if returned_on
			gear_item.update_attributes :rented => false
		else
			gear_item.update_attributes :rented => true
		end
	end


end
