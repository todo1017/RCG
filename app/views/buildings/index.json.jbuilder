json.array!(@buildings) do |building|
  json.extract! building, :id, :name, :description, :comp_group_id, :phone, :manager, :number_of_units, :website, :year_built, :year_remodeled
  json.url building_url(building, format: :json)
end
