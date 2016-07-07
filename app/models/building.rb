class Building < ActiveRecord::Base

  belongs_to :owner
  belongs_to :geography
  has_one :building_fee_schedule, dependent: :destroy
  has_one :building_amenity, dependent: :destroy
  has_one :building_unit_amenity, dependent: :destroy
  has_many :building_units, dependent: :destroy
  has_many :building_occupancies, dependent: :destroy

end
