json.array!(@amenity_concierges) do |amenity_concierge|
  json.extract! amenity_concierge, :id, :name
  json.url amenity_concierge_url(amenity_concierge, format: :json)
end
