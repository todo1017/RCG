json.array!(@comp_groups) do |comp_group|
  json.extract! comp_group, :id, :name
  json.url comp_group_url(comp_group, format: :json)
end
