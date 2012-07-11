class GearItemsController < ApplicationController

  before_filter :require_admin_login
  
  def new
    @gear_item = GearItem.new
  end

  def create
    GearItem.create params[:gear_item]
    redirect_to gear_item_types_path
  end
	
	def set_missing
		@type = params[:type]
		GearItem.update_all({:missing => true}, {:gear_item_type_id => @type})
		redirect_to gear_items_path(:type => @type)
	end

	def update_missing
		@type = params[:type]
		missing = params[:missing].map{|k, v| k.to_i}
		GearItem.update_all({:missing => false}, {:gear_item_type_id => @type})
		GearItem.update_all({:missing => true}, ['id in (?)', missing])
		redirect_to gear_items_path(:type => @type)
	end

	def index
		@type = params[:type]
		if params[:type]
			@gear_item_type = GearItemType.find(@type)
			@gear_items = GearItem.find_all_by_gear_item_type_id(params[:type])
			@label = 'Inventory'
		elsif params[:missing]
			@gear_items = GearItem.find_all_by_missing(true)
			@label = 'Missing inventory'
		elsif params[:rented]
			@gear_items = GearItem.find_all_by_rented(true)
			@label = 'Rented inventory'
		elsif params[:overdue]
			@gear_items = GearItem.overdue
			@label = 'Overdue inventory'
    elsif params[:retired]
      @gear_items = GearItem.retired
      @label = 'Retired inventory'
		else
			@gear_items = GearItem.all	
			@label = 'Entire inventory'
		end
	end

  def destroy
    @gear_item = GearItem.find(params[:id])
    @gear_item.update_attributes(:retired => Time.now)
    redirect_to gear_items_path
  end
	
	def update
		@gear_item = GearItem.find(params[:id])
		@gear_item.update_attributes params[:gear_item]
		redirect_to gear_item_path(@gear_item)
	end

	def show
		@gear_item = GearItem.find(params[:id])
		@notes = @gear_item.gear_item_notes
		@note = GearItemNote.new :gear_item_id => params[:id]
	end

	def import
	end

	def run_import
		GearItem.delete_all
		GearItemType.delete_all
		data = params[:import].read	
		lines = data.split(/[\r\n]+/)
		git = nil	
		lines.each do |line|
			if line_gear_item?(line)
				add_gear_item(line, git)
			else
				git = add_gear_item_type(line)
			end
		end

		redirect_to gear_items_path
	end

	protected

	def line_gear_item?(line)
		cols = line.split(',')
		return cols[0].blank?
	end

	def add_gear_item(line, git)
		if not git
			puts 'failed on gear item type'
			return
		end
		cols = line.split(',')
		
		identifier = cols[6]
		size = cols[7]
		value = cols[8]
		condition = cols[9]
		year_purchased = cols[10].to_i
		description = cols[11]
		missing = false
		comment = cols[14]

		gi = GearItem.new(	:identifier => identifier, 
												:gear_item_type_id => git.id,
												:size => size, 
												:value => value, 
												:condition => condition,
												:year_purchased => year_purchased, 
												:description => description, 
												:missing => missing, 
												:comment => comment)
		gi.save
	end

	def add_gear_item_type(line)
		cols = line.split(',')
		name = 							cols[0].downcase
		private_hire = 			cols[1].to_s.gsub(/[^0-9\.]/, '').to_i
		private_deposit = 	cols[2].to_s.gsub(/[^0-9\.]/, '').to_i
		club_hire =					cols[3].to_s.gsub(/[^0-9\.]/, '').to_i
		club_deposit = 			cols[4].to_s.gsub(/[^0-9\.]/, '').to_i
		git = GearItemType.new(	:name => name,
														:private_hire => private_hire,
														:private_deposit => private_deposit,
														:club_hire => club_hire,
														:club_deposit => club_deposit)
		git.save
		return git
	end
end




