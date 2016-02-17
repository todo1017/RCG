json.array!(@unit_types) do |unit_type|
  json.extract! unit_type, :id, :description, :beds, :baths, :sq_ft_low, :sq_ft_high, :floor_low, :floor_high
  json.url unit_type_url(unit_type, format: :json)
end
