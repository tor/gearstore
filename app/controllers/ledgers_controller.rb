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
		@to = Time.now

		@from = params[:from] if params[:from]
		@to = params[:to] if params[:to]

		@balance = Ledger.balance_until(@from)
		@entries = Ledger.where("created_at >= ? and created_at <= ?", @from, @to) 
		@totals = Ledger.totals(@from, @to)

    @new = Ledger.new
	end
end
