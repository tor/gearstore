class Rental < ActiveRecord::Base
	has_many :rental_items
	belongs_to :user
	accepts_nested_attributes_for :rental_items, :allow_destroy => true, :reject_if => lambda {|ri| ri[:gear_item_id].blank? }

	def self.active
		Rental.all.reject{|r| !r.active?}
	end

	def self.overdue
		Rental.all.reject{|r| !r.overdue?}
	end

	def approver
		User.find(approver_id)
	end
	
	def rented_on_pretty
		created_at.strftime('%Y %b %e')
	end

	def return_on_pretty
		return_on.strftime('%Y %b %e')
	end

	def overdue?
		return (Time.now > return_on and active?())
	end

	def returned_rental_items
		rental_items.reject{|ri| ri.returned_on.nil?}
	end

	def active?
		returned_rental_items.size < rental_items.size
	end

	def returned?
		!active?		
	end
end





