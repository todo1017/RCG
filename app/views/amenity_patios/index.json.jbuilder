json.array!(@amenity_patios) do |amenity_patio|
  json.extract! amenity_patio, :id, :name
  json.url amenity_patio_url(amenity_patio, format: :json)
end
