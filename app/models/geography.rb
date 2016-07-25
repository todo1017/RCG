class Geography < ActiveRecord::Base

  has_many :buildings
  has_many :user_geographies

end
