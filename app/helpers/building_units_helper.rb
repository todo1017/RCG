module BuildingUnitsHelper

  def comp_query_var(building_unit, comp_group_id, geography_id)
    BuildingUnit.joins(:building).where(buildings: {competitor: true, comp_group_id: comp_group_id, geography_id: geography_id})
  end

  def comps_query_1(building_unit, comp_group_id, geography_id)
    beds = building_unit.beds
    baths = building_unit.baths
    floor = building_unit.floor

    comp_apartments = comp_query_var(building_unit, comp_group_id, geography_id)

    first = comp_apartments.where(beds: beds, baths: baths, floor: [floor-1, floor, floor+1])

  end

  def comps_query_2(building_unit, comp_group_id, geography_id)
    beds = building_unit.beds
    baths = building_unit.baths
    floor = building_unit.floor

    comp_apartments = comp_query_var(building_unit, comp_group_id, geography_id)

    first = comp_apartments.where(beds: beds, baths: baths, floor: [floor-1, floor, floor+1])
    second = comp_apartments.where(beds: beds, baths: baths, floor: [floor-2, floor+2])
    # third

    # USE the "first" query for the count but it's already been displayed so don't return it again here
    if first.count + second.count > 0 then return second end

    four_a = BuildingUnit.where(beds: beds-1, baths: baths, floor: [floor])

    if four_a.count > 2 then return four_a end

    four_b = BuildingUnit.where(beds: beds-1, baths: baths, floor: [floor-1, floor+1, floor-2, floor+2])

    return four_a + four_b

  end


end
