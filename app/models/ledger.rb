class Ledger < ActiveRecord::Base
  belongs_to :user

  def self.types
    ['returns', 'deposit', 'fee', 'trip fees', 'sales', 'rope fees', 'membership', 'confiscated deposit', 'ledger correction', 'custom']
  end

  def self.type_names
    { 'returns' => 'returns',
      'deposit' => 'deposits taken',
      'fee' => 'fees taken',
      'trip fees' => 'trip fees',
      'sales' => 'sales',
      'rope fees' => 'rope fees',
      'membership' => 'membership fees',
      'confiscated deposit' => 'confiscated deposits',
      'ledger correction' => 'ledger corrections',
      'custom' => 'custom'
    }
  end

	def self.balance_until time
		Ledger.sum(:amount, :conditions => ['created_at <= ?', time])		
	end

	def self.balance_between(s, e)
		Ledger.sum(:amount, :conditions => ['created_at >= ? and created_at <= ?', s, e])
	end

	def self.totals(s, e)
		entries = Ledger.find(:all, :conditions => ['created_at >= ? and created_at <= ?', s, e])
    
    totals = types.inject({}) do |x, type|
      x.merge(type => entries.reject{|e| e.description != type}.inject(0) {|t,e| t+=e.amount})
    end
    totals['returns'] = entries.reject{|e| e.description.match('deposit returned') == nil}.inject(0) {|t,e| t += e.amount}
    return totals
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
