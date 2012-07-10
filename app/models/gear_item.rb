class GearItem < ActiveRecord::Base
  set_table_name 'gs3_gear_items'

	belongs_to :gear_item_type
	has_many :rental_items
	has_many :gear_item_notes

	def rented_to
		return nil if not rented
		rental_items.reject{|i| !i.returned_on.nil?}.first.rental.user
	end

	def clean_description
		description.to_s.gsub(/[^a-zA-Z0-9 ]/, '')
	end

	def name
		"#{identifier} : #{clean_description}"	
	end

	def self.overdue
		Rental.overdue.map{|rental| rental.rental_items.reject{|ri| ri.returned_on != nil}.map{|ri| ri.gear_item}}.flatten
	end

  def self.retired
    GearItem.find(:all, :conditions => ['retired != ?', nil])
  end
end
