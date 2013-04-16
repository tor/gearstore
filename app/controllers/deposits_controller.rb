class DepositsController < ApplicationController

  before_filter :require_admin_login
	def index
		if not params[:search].blank?
			@users = User.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
			@label = "Deposits for \"#{params[:search]}\""
		else
      @users = Deposit.find(:all, :conditions => ['amount != 0']).map{|d| d.user}
			@label = "Deposits"
		end
	end

	def show 
		@deposit = Deposit.find(params[:id])
	end

	def claim
		@deposit = Deposit.find(params[:id])
	end

	def update
		@deposit = Deposit.find(params[:id])
		if !params[:return_amount].blank? and params[:return_amount].to_i <= @deposit.amount
			@deposit.update_attributes(:amount => @deposit.amount - params[:return_amount].to_i)
			Ledger.create!(:amount => -params[:return_amount].to_i, :description => "deposit returned to #{@deposit.user.name}", :approver_id => params[:approver_id]) 
			redirect_to deposits_path
		elsif !params[:claim_amount].blank? and params[:claim_amount].to_i <= @deposit.amount
			@deposit.update_attributes(:amount => @deposit.amount - params[:claim_amount].to_i)
			Ledger.create!(:amount => params[:claim_amount].to_i, :description => "deposit reclaimed from #{@deposit.user.name}", :approver_id => params[:approver_id]) 
			redirect_to deposits_path
		else
			redirect_to deposits_path
		end
	end
end
