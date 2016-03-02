json.array!(@user_geographies) do |user_geography|
  json.extract! user_geography, :id, :user_id, :geography_id, :access_type
  json.url user_geography_url(user_geography, format: :json)
end
