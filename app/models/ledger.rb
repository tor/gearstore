class Ledger < ActiveRecord::Base
  belongs_to :user

	def self.balance_until time
		Ledger.sum(:amount, :conditions => ['created_at <= ?', time])		
	end

	def approver
		User.find(approver_id)
	end

  def is_rental?
  end

  def is_deposit?
  end
end
