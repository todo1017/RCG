class BuildingUnit < ActiveRecord::Base

  validates :building_id, :floor, :beds, :baths, :sq_feet, :actual_rent, presence: true

  belongs_to :building

  scope :owned, -> { joins(:building).where(buildings: {competitor: false}) }
  scope :competitors, -> { joins(:building).where(buildings: {competitor: true}) }

  # THIS initializes the Building...
  def self.import(file)

    xlsx = Roo::Spreadsheet.open(file)

    # header = sheet.row(1)
    #   row = Hash[[header, sheet.row(i)].transpose]

    xlsx.each_with_pagename do |building_name, sheet|
      puts building_name
      puts building_name
      puts building_name

      counter = 0
      (2..sheet.last_row).each do |i|
        bulding_unit = find_or_initialize_by(building_id: Building.where(name: building_name).first.id, number: sheet.cell("A", i).to_s)

        bulding_unit.update floor: sheet.cell("B", i).to_s if sheet.cell("B", i) != nil
        bulding_unit.update beds: sheet.cell("C", i).to_i if sheet.cell("C", i) != nil
        bulding_unit.update baths: sheet.cell("D", i).to_s if sheet.cell("D", i) != nil
        bulding_unit.update sq_feet: 0
        bulding_unit.update market_rent: 0
        bulding_unit.update actual_rent: 0

        bulding_unit.save!
        counter = counter +1
      end
      puts counter.to_s
      puts counter.to_s
      puts counter.to_s
    end
  end

  def self.import_yardi_1(file)

    sheet = Roo::Spreadsheet.open(file)

    # xlsx.each_with_pagename do |name, sheet|
    # end
    # header = sheet.row(1)
    #   row = Hash[[header, sheet.row(i)].transpose]

    building_name = sheet.cell("A", 2).to_s
    puts building_name
    puts building_name
    puts building_name

    counter = 0
    (8..sheet.last_row).each do |i|
      if sheet.cell("A", i) != nil
        # TODO -- convert this to find_by
        bulding_unit = find_by(building_id: Building.where(name: building_name).first.id, number: sheet.cell("A", i).to_s)

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
        bulding_unit.update move_in: Date.strptime(sheet.cell("J", i), "%m/%d/%Y") if sheet.cell("J", i) != nil
        bulding_unit.update lease_expiration: Date.strptime(sheet.cell("K", i), "%m/%d/%Y") if sheet.cell("K", i) != nil
        bulding_unit.update move_out: Date.strptime(sheet.cell("L", i), "%m/%d/%Y") if sheet.cell("L", i) != nil
        bulding_unit.update notes: sheet.cell("M", i).to_s if sheet.cell("M", i) != nil

        bulding_unit.save!
        counter = counter +1
      end
    end
    puts counter.to_s
    puts counter.to_s
    puts counter.to_s
  end

end
