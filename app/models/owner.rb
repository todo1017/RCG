class Owner < ActiveRecord::Base

  has_many :users
  has_many :buildings

end
