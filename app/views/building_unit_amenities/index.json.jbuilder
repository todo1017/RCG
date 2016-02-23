json.array!(@building_unit_amenities) do |building_unit_amenity|
  json.extract! building_unit_amenity, :id, :building_id, :washer_dryer, :washer_dryer_, :microwave, :microwave_, :security_alarm, :security_alarm_, :amenity_ceiling_id, :ceiling_, :amenity_patio_id, :patio_, :oversized_windows, :oversized_windows_, :other, :other_
  json.url building_unit_amenity_url(building_unit_amenity, format: :json)
end
