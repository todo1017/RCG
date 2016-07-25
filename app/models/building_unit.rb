class BuildingUnit < ActiveRecord::Base

  require 'date'

  validates :building_id, :floor, :beds, :baths, :sq_feet, :actual_rent, presence: true

  belongs_to :building

  scope :owned, -> { joins(:building).where(buildings: {competitor: false}) }
  scope :competitors, -> { joins(:building).where(buildings: {competitor: true}).order(:building_id, :floor, :beds, :baths) }


  # THIS initializes the Building...
  # THIS initializes the Building...
  # THIS initializes the Building...
  def self.import(file)

    xlsx = Roo::Spreadsheet.open(file)

    xlsx.each_with_pagename do |building_name, sheet|

      if Building.where(name: building_name).blank?
        return "Building Import - sorry, misnamed Building: " + building_name
      end

      message_to_display = "Building Import - "

      counter = 0
      (2..sheet.last_row).each do |i|
        begin
          bulding_unit = find_or_initialize_by(building_id: Building.where(name: building_name).first.id, number: sheet.cell("A", i).to_s.strip)

          bulding_unit.update floor: sheet.cell("B", i).to_s if sheet.cell("B", i) != nil
          bulding_unit.update beds: sheet.cell("C", i).to_i if sheet.cell("C", i) != nil
          bulding_unit.update baths: sheet.cell("D", i).to_s if sheet.cell("D", i) != nil
          bulding_unit.update add_room: true if sheet.cell("E", i) == "Y"
          bulding_unit.update sq_feet: 0
          bulding_unit.update market_rent: 0
          bulding_unit.update actual_rent: 0

          # TODO what happens if this is the 2-3 update?
          bulding_unit.update import_number: 1

          bulding_unit.save!
          counter = counter +1
        rescue
          message_to_display = message_to_display + "problem with row #" + counter.to_s + " (partially updated)..."
          next
        end
      end
      message_to_display = message_to_display + "Total Rows Created/Updated: " + counter.to_s
      return message_to_display
    end
  end

  # Yardi Import...
  # Yardi Import...
  # Yardi Import...
  def self.import_yardi_1(file)

    sheet = Roo::Spreadsheet.open(file)

    building_name = sheet.cell("A", 2).to_s

    if Building.where(name: building_name).blank?
      return "Yardi Import - sorry, misnamed Building: " + building_name
    end

    previous_import_number = where(building_id: Building.where(name: building_name).first.id).order("import_number").last.import_number

    message_to_display = "Yardi Import - "

    counter = 0
    future_records = "no"
    (8..sheet.last_row).each do |i|
      if sheet.cell("A", i) != nil && sheet.cell("A", i) == "Future Residents/Applicants"
        future_records = "yes"
      end
      begin
        if sheet.cell("A", i) != nil && sheet.cell("A", i) != "Future Residents/Applicants"
          counter = counter +1
          apartment_number = sheet.cell("A", i).to_s.strip
          if apartment_number.include?(".")
            apartment_number = apartment_number.chomp(".0")
          end
          bulding_unit_ = find_by(building_id: Building.where(name: building_name).first.id, number: apartment_number, import_number: previous_import_number)
          if bulding_unit_ == nil
            bulding_unit_ = find_by(building_id: Building.where(name: building_name).first.id, number: apartment_number, import_number: previous_import_number-1)
          end
          bulding_unit = bulding_unit_.dup

          bulding_unit.update bed_bath: sheet.cell("B", i).to_s if sheet.cell("B", i) != nil

          bulding_unit.update sq_feet: sheet.cell("C", i).to_i if sheet.cell("C", i) != nil
          bulding_unit.update resident_id: sheet.cell("D", i).to_s if sheet.cell("D", i) != nil
          bulding_unit.update resident_name: sheet.cell("E", i).to_s if sheet.cell("E", i) != nil

          bulding_unit.update market_rent: sheet.cell("F", i).to_f if sheet.cell("F", i) != nil
          if sheet.cell("G", i) == nil
            bulding_unit.update actual_rent: 0
          else
            bulding_unit.update actual_rent: sheet.cell("G", i).to_f
          end
          bulding_unit.update resident_deposit: sheet.cell("H", i).to_f if sheet.cell("H", i) != nil
          bulding_unit.update other_deposit: sheet.cell("I", i).to_f if sheet.cell("I", i) != nil
          bulding_unit.update notes: sheet.cell("M", i).to_s if sheet.cell("M", i) != nil
          if sheet.cell("J", i) != nil
            if sheet.cell("J", i).is_a?(Date)
              bulding_unit.update move_in: sheet.cell("J", i)
            else
              bulding_unit.update move_in: Date.strptime(sheet.cell("J", i), "%m/%d/%Y")
            end
          end
          if sheet.cell("K", i) != nil
            if sheet.cell("K", i).is_a?(Date)
              bulding_unit.update lease_expiration: sheet.cell("K", i)
            else
              bulding_unit.update lease_expiration: Date.strptime(sheet.cell("K", i), "%m/%d/%Y")
            end
          end
          if sheet.cell("L", i) != nil
            if sheet.cell("L", i).is_a?(Date)
              bulding_unit.update move_out: sheet.cell("L", i)
            else
              bulding_unit.update move_out: Date.strptime(sheet.cell("L", i), "%m/%d/%Y")
            end
          end
          if future_records == "no"
            bulding_unit.update relevant_start_date: Date.strptime("01/01/1910", "%m/%d/%Y")
            bulding_unit.update relevant_end_date: Date.strptime("12/31/2090", "%m/%d/%Y")
          elsif future_records == "yes"
            if sheet.cell("J", i) != nil
              if sheet.cell("J", i).is_a?(Date)
                future_move_in_date = sheet.cell("J", i)
              else
                future_move_in_date = Date.strptime(sheet.cell("J", i), "%m/%d/%Y")
              end
            end
            bulding_unit.update relevant_start_date: future_move_in_date
            bulding_unit.update relevant_end_date: Date.strptime("12/31/2090", "%m/%d/%Y")
            expiring_record_for_the_building_unit = find_by(building_id: Building.where(name: building_name).first.id, number: apartment_number, import_number: previous_import_number+1)
            expiring_record_for_the_building_unit.update relevant_end_date: future_move_in_date - 1
            expiring_record_for_the_building_unit.save
          end

          bulding_unit.update import_number: previous_import_number+1
          bulding_unit.save!
        end
      rescue StandardError => error
        message_to_display = message_to_display + "problem with unit ##{sheet.cell("A", i).to_s.strip} (#{error.message})........"
        bulding_unit.update import_number: previous_import_number+1
        bulding_unit.save!
        next
      end
    end
    message_to_display = message_to_display + "Total Rows Updated: " + counter.to_s
    return message_to_display
  end

  # header = sheet.row(1)
  #   row = Hash[[header, sheet.row(i)].transpose]

end
