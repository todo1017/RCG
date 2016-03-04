class BuildingUnit < ActiveRecord::Base

  validates :building_id, :floor, :beds, :baths, :sq_feet, :actual_rent, presence: true

  belongs_to :building

  scope :owned, -> { joins(:building).where(buildings: {competitor: false}) }
  scope :competitors, -> { joins(:building).where(buildings: {competitor: true}) }

  def self.import(file)

    xlsx = Roo::Spreadsheet.open(file)

    xlsx.each_with_pagename do |name, sheet|
      header = sheet.row(1)

      (2..sheet.last_row).each do |i|
        row = Hash[[header, sheet.row(i)].transpose]

        bulding_unit = find_or_initialize_by(building_id: Building.where(name: name).first.id, number: row["number"].to_s)

        bulding_unit.update bed_bath: row["unit_type"].to_s if row["unit_type"] != nil

        # bulding_unit.update
        bulding_unit.update sq_feet: row["sq_feet"].to_i if row["sq_feet"] != nil
        bulding_unit.update resident_name: row["resident_name"].to_s if row["resident_name"] != nil

        bulding_unit.update market_rent: row["market_rent"].to_f if row["market_rent"] != nil
        bulding_unit.update actual_rent: row["actual_rent"].to_f if row["actual_rent"] != nil
        bulding_unit.update resident_deposit: row["resident_deposit"].to_f if row["resident_deposit"] != nil
        bulding_unit.update other_deposit: row["other_deposit"].to_f if row["other_deposit"] != nil
        bulding_unit.update move_in: Date.strptime(row["move_in"], "%m/%d/%Y") if row["move_in"] != nil
        bulding_unit.update lease_expiration: Date.strptime(row["lease_expiration"], "%m/%d/%Y") if row["lease_expiration"] != nil
        bulding_unit.update move_out: Date.strptime(row["move_out"], "%m/%d/%Y") if row["move_out"] != nil
        bulding_unit.update notes: row["notes"].to_s if row["notes"] != nil
        bulding_unit.update resident_id: row["resident_id"].to_s if row["resident_id"] != nil
        bulding_unit.save!
      end

    end

  end

end
