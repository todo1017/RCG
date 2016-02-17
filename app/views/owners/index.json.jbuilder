json.array!(@owners) do |owner|
  json.extract! owner, :id, :name, :description, :competitor
  json.url owner_url(owner, format: :json)
end
