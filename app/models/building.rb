class Building < ActiveRecord::Base

  belongs_to :owner
  has_one :building_fee_schedule
  has_one :building_amenity
  has_many :building_units

end
