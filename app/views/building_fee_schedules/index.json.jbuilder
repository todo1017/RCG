json.array!(@building_fee_schedules) do |building_fee_schedule|
  json.extract! building_fee_schedule, :id, :building_id, :parking, :parking_, :parking_extra, :parking_extra_, :security_deposit, :security_deposit_, :amenity_fee, :amenity_fee_, :trash_fee, :trash_fee_, :pet_deposit, :pet_deposit_, :pet_dog, :pet_dog_, :pet_cat, :pet_cat_, :application_fee, :application_fee_, :minimum_lease, :minimum_lease_, :monthly_fees, :monthly_fees_, :yearly_fees, :yearly_fees_
  json.url building_fee_schedule_url(building_fee_schedule, format: :json)
end
