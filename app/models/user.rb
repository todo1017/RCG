class User < ActiveRecord::Base

  has_secure_password

  validates_uniqueness_of :email

  belongs_to :owner

end
