class GearItemNote < ActiveRecord::Base
	belongs_to :gear_item
	belongs_to :rental_item

	def approver
		User.find(approver_id)
	end
end
