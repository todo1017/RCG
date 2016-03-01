module BuildingUnitsHelper

  def concessions_calc(building_unit)
    if building_unit.months_off != nil && building_unit.cash_off != nil
      return ((building_unit.sq_feet * building_unit.months_off) + building_unit.cash_off)
    end
    return 0
  end

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

    # 1, 2 and 3
    # 1, 2 and 3
    # 1, 2 and 3
    first = comp_apartments.where(beds: beds, baths: baths, floor: [floor-1, floor, floor+1])
    second = comp_apartments.where(beds: beds, baths: baths, floor: [floor-2, floor+2])

    third = closet_floor_away_record(comp_apartments, beds, 0, baths, floor, 2)

    # USE the "first" query for the count
    # but it's already been displayed so don't return it again here
    if first.count + second.count + third.count > 0
      return second + third
    end

    # 4
    # 4
    # 4
    four_a = comp_apartments.where(beds: beds-1, baths: baths, floor: floor)

    if four_a.count > 2
      return four_a
    end

    four_b = comp_apartments.where(beds: beds-1, baths: baths, floor: [floor-1, floor+1, floor-2, floor+2])

    if four_a.count + four_b.count > 2
      return four_a + four_b
    end

    four_c = closet_floor_away_record(comp_apartments, beds, -1, baths, floor, 2)

    return four_a + four_b + four_c

  end

  def closet_floor_away_record(comp_apartments, beds, offset, baths, floor, hurdle)
    floor_record = comp_apartments.where(beds: beds+offset, baths: baths).order("abs(floor-#{floor})").first
    if floor_record != nil && (floor - floor_record.floor).abs > hurdle
      four_c = comp_apartments.where(beds: beds+offset, baths: baths, floor: floor_record.floor)
    else
      four_c = comp_apartments.where(beds: 101)
    end
  end


end
