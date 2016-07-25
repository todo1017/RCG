class Owner < ActiveRecord::Base

  has_many :users
  has_many :buildings
  has_many :owner_users

end
