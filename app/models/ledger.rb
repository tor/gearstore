class Ledger < ActiveRecord::Base
  belongs_to :user

	def self.balance_until time
		Ledger.sum(:amount, :conditions => ['created_at <= ?', time])		
	end

	def self.balance_between(s, e)
		Ledger.sum(:amount, :conditions => ['created_at >= ? and created_at <= ?', s, e])
	end

	def self.totals(s, e)
		entries = Ledger.find(:all, :conditions => ['created_at >= ? and created_at <= ?', s, e])

		return {
			:fees => entries.reject{|e| e.description != 'fee'}.inject(0) {|t,e| t += e.amount},
			:deposits => entries.reject{|e| e.description != 'deposit'}.inject(0) {|t,e| t += e.amount},
			:returns => entries.reject{|e| e.description.match('deposit returned') == nil}.inject(0) {|t,e| t += e.amount},
			:other => entries.reject{|e| e.description.match('deposit returned|fee') or e.description == 'deposit'}.inject(0) {|t,e| t+= e.amount}
		}
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
