class GearItem < ActiveRecord::Base
  set_table_name 'gs3_gear_items'

  default_scope :conditions => {:retired => nil}
	belongs_to :gear_item_type
	has_many :rental_items
	has_many :gear_item_notes


	def rented_to
		return nil if not rented
		item = rental_items.reject{|i| !i.returned_on.nil?}.first
		return nil if item == nil
		return item.rental.user
	end
	
	def rented_to_name
	  return '' if not rented
	  user = rented_to
	  return user != nil ? user.name : 'Unknown User'
	end

	def clean_description
		description.to_s.gsub(/[^a-zA-Z0-9 ]/, '')
	end

	def name
		"#{identifier} : #{clean_description}"	
	end

  def retire
    update_attributes(:retired => Time.now)
  end

	def self.overdue
		Rental.overdue.map{|rental| rental.rental_items.reject{|ri| ri.returned_on != nil}.map{|ri| ri.gear_item}}.flatten
	end

  def self.retired
    GearItem.find(:all, :conditions => ['retired != ?', nil])
  end
end
