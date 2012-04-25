class GearItemType < ActiveRecord::Base
	has_many :gear_items

	def self.all_sorted
		self.all.sort{|x, y| x.name <=> y.name}
	end

	def self.all_available
		self.all_sorted.reject{|git| !git.some_available?}
	end

	def available_gear_items
    case sort_type
      when 'description'
        GearItem.find(:all, :conditions => {:gear_item_type_id => id, :rented => false, :retired => nil}).sort{|x, y| x.description <=> y.description}
      when 'identifier (alpha)'
        GearItem.find(:all, :conditions => {:gear_item_type_id => id, :rented => false, :retired => nil}).sort{|x, y| x.identifier <=> y.identifier}
      when 'identifier (number)'
        GearItem.find(:all, :conditions => {:gear_item_type_id => id, :rented => false, :retired => nil}).sort{|x, y| x.identifier.to_i <=> y.identifier.to_i}
    end
	end

	def some_available?
		GearItem.find(:first, :conditions => {:gear_item_type_id => id, :rented => false, :retired => nil}) != nil
	end
end
