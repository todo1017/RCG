class OwnerUser < ActiveRecord::Base

  belongs_to :owner
  belongs_to :user

end
