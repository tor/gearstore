class Ledger < ActiveRecord::Base
  belongs_to :user

	def self.balance_until time
		Ledger.sum(:amount, :conditions => ['created_at <= ?', time])		
	end

  def self.fees_taken_today
    return Ledger.sum(:amount, :conditions => ['created_at >= ? and description = ?', Time.now.beginning_of_day, 'fee'])
  end

  def self.deposits_taken_today
    return Ledger.sum(:amount, :conditions => ['created_at >= ? and description = ?', Time.now.beginning_of_day, 'deposit'])
  end

  def self.deposits_returned_today
    return Ledger.sum(:amount, :conditions => ['created_at >= ? and description like ?', Time.now.beginning_of_day, '%deposit returned%'])
  end

	def approver
		User.find(approver_id)
	end

  def is_rental?
  end

  def is_deposit?
  end
end
