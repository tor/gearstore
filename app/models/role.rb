class Role < ActiveRecord::Base
  set_primary_key 'id'
  has_and_belongs_to_many :users
end
