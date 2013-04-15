class User < ActiveRecord::Base
  set_primary_key 'id'

	has_many :rentals
	has_one :deposit

  has_and_belongs_to_many :roles

	def self.admins
    # 23 is the role id for gear store officers.
    Role.find(23).users.sort{|x, y| x.name <=> y.name}
	end

  def self.authenticate(user, pass)
    u = User.find(:first, :conditions => {:username => user, :pass => Digest::MD5.hexdigest(pass)})
    return (u and u.admin?)?u:nil
  end

  def admin?
    roles.reject{|r| r.id != 23}.size > 0
  end

	def deposit_amount
		return (deposit.nil?)?(0):(deposit.amount)
	end

	def rental_number
		rentals.reject{|r| !r.active?}.size	
	end

	def overdue_rental_number
		rentals.reject{|r| !r.overdue?}.size
	end

	def has_overdue?
		overdue_rental_number > 0 
	end

  def has_active?
		rentals.reject{|r| !r.active?}.size > 0
  end
end
