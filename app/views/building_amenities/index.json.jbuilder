json.array!(@building_amenities) do |building_amenity|
  json.extract! building_amenity, :id, :building_id, :business_center, :business_center_, :resident_lounge, :resident_lounge_, :screening_room, :screening_room_, :rooftop_deck, :rooftop_deck_, :train_station, :train_station_, :pool, :pool_, :gated, :gated_, :concierge, :concierge_, :recreation, :recreation_, :fitness, :fitness_, :other, :amenity_1, :amenity_1_, :amenity_1_name, :amenity_2, :amenity_2_, :amenity_2_name, :amenity_3, :amenity_3_, :amenity_3_name, :amenity_11, :amenity_11_, :amenity_11_name, :amenity_12, :amenity_12_, :amenity_12_name
  json.url building_amenity_url(building_amenity, format: :json)
end
