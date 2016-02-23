json.array!(@amenity_ceilings) do |amenity_ceiling|
  json.extract! amenity_ceiling, :id, :name
  json.url amenity_ceiling_url(amenity_ceiling, format: :json)
end
