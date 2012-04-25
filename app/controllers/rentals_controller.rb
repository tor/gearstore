class RentalsController < ApplicationController
  before_filter :require_admin_login
	def index
		if params[:search_new]
			@users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:search_new]}%"])
			@label = "New rental for \"#{params[:search_new]}\""
		elsif params[:search]
			@users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
			@rentals = @users.map{|u| u.rentals}.flatten
			@label = "Rentals for \"#{params[:search]}\""
		elsif params[:overdue]
			@rentals = Rental.overdue
			@label = "Overdue rentals"
		elsif params[:all]
			@rentals = Rental.all
			@label = "All rentals"
		else
			@rentals = Rental.active
			@label = "Current rentals"
		end
	end

	def new
		@user = User.find(params[:user_id])
		@rental = Rental.new
		@rental.user_id = @user.id
		@rental.return_on = Time.now + 1.week
		@rental.rental_items.build

		@gear_item_types = GearItemType.all_sorted
		@options = "{" + @gear_item_types.map do |type|
			"#{type.id} : '" + type.available_gear_items.map{|i| "<option value=\"#{i.id}\">#{i.identifier} : #{i.clean_description}</option>"}.join + "'"
		end.join(",") + "}"

		@gear_club_fee = "{" + @gear_item_types.map{|git| "#{git.id} : #{git.club_hire}"}.join(",") + "}";
		@gear_club_deposit = "{" + @gear_item_types.map{|git| "#{git.id} : #{git.club_deposit}"}.join(",") + "}";
		@gear_private_fee = "{" + @gear_item_types.map{|git| "#{git.id} : #{git.private_hire}"}.join(",") + "}";
		@gear_private_deposit = "{" + @gear_item_types.map{|git| "#{git.id} : #{git.private_deposit}"}.join(",") + "}";
	end
	
	def update
		@rental = Rental.find(params[:id])
		ret = params[:returned]?params[:returned]:{}
		mis = params[:missing]?params[:missing]:{}
		returned = (ret.map{|id,val| id} + mis.map{|id,val| id}).uniq 
		returned.each do |id|
			puts params[:returned_note[id]]
			puts params['returned_note']
			rental_item = RentalItem.find(id)
			rental_item.update_attributes(
							:returned_on => Time.now, 
							:return_approver_id => params[:approver_id], 
							:return_note => params['returned_note'][id],
							:missing => (mis[id] != nil))
			GearItemNote.create! 	:note => params['returned_note'][id], 
														:rental_item_id => rental_item.id, 
														:gear_item_id => rental_item.gear_item_id,
														:approver_id => params[:approver_id]

			if mis[id]
				rental_item.gear_item.update_attributes(:missing => true)
			end
		end

		redirect_to rental_path
	end

	def create
		r = Rental.create(params[:rental])
		user = r.user 
		deposit = (user.deposit.nil?)?(Deposit.new(:user_id => user.id, :amount => 0)):user.deposit
		deposit.update_attributes(:amount => user.deposit_amount + r.deposit)
		
		Ledger.create! :amount => r.deposit, 	:description => 'deposit',  :approver_id => r.approver_id, :user_id => user.id
		Ledger.create! :amount => r.fee, 			:description => 'fee',      :approver_id => r.approver_id, :user_id => user.id

		redirect_to rental_path
	end

	def show
		@rental = Rental.find(params[:id])
	end


	private

end
