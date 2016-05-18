module BuildingUnitsHelper

  def add_to_array(counter, comp)
    if counter == 0
      @additional_row_0 << comp
    elsif counter == 1
      @additional_row_1 << comp
    elsif counter == 2
      @additional_row_2 << comp
    elsif counter == 3
      @additional_row_3 << comp
    elsif counter == 4
      @additional_row_4 << comp
    end
  end

  # Simple column values -- used by HTML and XLS
  # Simple column values -- used by HTML and XLS
  # Simple column values -- used by HTML and XLS

  def unit_type(building_unit)
    return building_unit.floor.to_s + " FL " + building_unit.beds.to_s + "Bed/" + building_unit.baths.to_s + "Bath " + building_unit.sq_feet.to_s + " sq. ft."
  end

  def available(building_unit)
    if building_unit.actual_rent == 0
      return "now"
    else
      available_date = building_unit.lease_expiration
      available_date += 1
      return available_date.strftime("%B %e")
    end
  end

  def gross_sq_foot(building_unit, apt_type="")
    if building_unit.sq_feet == 0
      return 0
    elsif apt_type == "comp"
      return ('%.2f' % (building_unit.actual_rent / building_unit.sq_feet))
      # return number_to_currency('%.2f' % (building_unit.actual_rent / building_unit.sq_feet))
    else
      return ('%.2f' % (building_unit.market_rent / building_unit.sq_feet))
      # return number_to_currency('%.2f' % (building_unit.market_rent / building_unit.sq_feet))
    end
  end

  def net_sq_foot(building_unit, apt_type="")
    if building_unit.lease_length != nil && building_unit.lease_length > 0
      demoninator = building_unit.lease_length
    else
      demoninator = 12
    end
    if building_unit.sq_feet == 0
      return 0
    elsif apt_type == "comp"
      return ('%.2f' % ((building_unit.actual_rent - (concessions_calc(building_unit, "comp")/demoninator)) / building_unit.sq_feet))
      # return number_to_currency('%.2f' % ((building_unit.actual_rent - (concessions_calc(building_unit, "comp")/demoninator)) / building_unit.sq_feet))
    else
      return ('%.2f' % ((building_unit.market_rent - (concessions_calc(building_unit, "owned")/demoninator)) / building_unit.sq_feet))
      # return number_to_currency('%.2f' % ((building_unit.market_rent - (concessions_calc(building_unit, "owned")/demoninator)) / building_unit.sq_feet))
    end
  end

  # More complex calculations
  # More complex calculations
  # More complex calculations

  def concessions_calc(building_unit, type)
    if building_unit.months_off == nil then building_unit.months_off = 0 end
    if building_unit.cash_off == nil then building_unit.cash_off = 0 end
    if type == "comp"
      return ((building_unit.actual_rent * building_unit.months_off) + building_unit.cash_off)
    else
      return ((building_unit.market_rent * building_unit.months_off) + building_unit.cash_off)
    end
    return 0
  end

  def concessions_currency(building_unit, type)
    return number_to_currency(concessions_calc(building_unit, type))
  end

  # def comp_query_var(building_unit, comp_group_id, geography_id, comp_building_id)
  #   BuildingUnit.joins(:building).where(buildings: {competitor: true, comp_group_id: comp_group_id, geography_id: geography_id, id: comp_building_id})
  # end

  def comps_query_1(building_unit, comp_building_id)
    beds = building_unit.beds
    baths = building_unit.baths
    floor = building_unit.floor
    comp_apartments = BuildingUnit.where(building_id: comp_building_id)

    return comp_apartments.where(beds: beds, baths: baths, floor: [floor-1, floor, floor+1])

  end

  def comps_query_2(building_unit, comp_building_id)
    beds = building_unit.beds
    baths = building_unit.baths
    floor = building_unit.floor
    comp_apartments = BuildingUnit.where(building_id: comp_building_id)

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

    if four_a.count + four_b.count + four_c.count > 2
      return four_a + four_b + four_c
    end

    # 5
    # 5
    # 5
    five_a = comp_apartments.where(beds: beds+1, baths: baths, floor: floor)

    if five_a.count > 2
      return four_a + four_b + four_c + five_a
    end

    five_b = comp_apartments.where(beds: beds+1, baths: baths, floor: [floor-1, floor+1, floor-2, floor+2])

    if five_a.count + five_b.count > 2
      return four_a + four_b + four_c + five_a + five_b
    end

    five_c = closet_floor_away_record(comp_apartments, beds, +1, baths, floor, 2)

    return four_a + four_b + four_c + five_a + five_b + five_c

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
