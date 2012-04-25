class LedgersController < ApplicationController

  before_filter :require_admin_login

  def create
    @entry = Ledger.new(params[:ledger])
    if params[:reconcile]
      @entry.amount = @entry.amount - Ledger.balance_until(Time.now)
      @entry.description = 'reconcile: ' + @entry.description
    end
    @entry.save
    redirect_to ledgers_path
  end

	def index
		@from = Time.now.beginning_of_day
		case params[:from]
			when 'week'
				@from = Time.now.beginning_of_week
			when 'month'
				@from = Time.now.beginning_of_month
			when 'all'
				@from = Time.new("2000")
		end
		@balance = Ledger.balance_until(@from)
		@entries = Ledger.where("created_at >= ?", @from) 

    @new = Ledger.new
	end
end
