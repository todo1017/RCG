class Building < ActiveRecord::Base

  belongs_to :owner
  has_many :building_units

end
