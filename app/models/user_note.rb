class UserNote < ActiveRecord::Base
	def approver
		User.find(approver_id)
	end
end
