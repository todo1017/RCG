json.array!(@building_units) do |building_unit|
  json.extract! building_unit, :id, :number, :building_id, :unit_type_id, :sq_feet, :resident_name, :market_rent, :actual_rent, :resident_deposit, :other_deposit, :move_in, :move_out, :lease_expiration, :notes
  json.url building_unit_url(building_unit, format: :json)
end
