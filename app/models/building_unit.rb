class BuildingUnit < ActiveRecord::Base

  def self.import(file)

    xlsx = Roo::Spreadsheet.open(file)
    header = xlsx.row(1)

    (2..xlsx.last_row).each do |i|
      row = Hash[[header, xlsx.row(i)].transpose]

      bulding_unit = find_or_initialize_by(number: row["number"].to_s)

      # bulding_unit.update ?????: row["unit_type"].to_s
      # bulding_unit.update ??????: row["resident_id"].to_s

      bulding_unit.update building_id: xlsx.sheets.first.to_i
      bulding_unit.update sq_feet: row["sq_feet"].to_i
      bulding_unit.update resident_name: row["resident_name"].to_s

      bulding_unit.update market_rent: row["market_rent"].to_f
      bulding_unit.update actual_rent: row["actual_rent"].to_f
      bulding_unit.update resident_deposit: row["resident_deposit"].to_f
      bulding_unit.update other_deposit: row["other_deposit"].to_f
      bulding_unit.update move_in: Date.strptime(row["move_in"], "%m/%d/%Y")
      bulding_unit.update lease_expiration: Date.strptime(row["lease_expiration"], "%m/%d/%Y")
      bulding_unit.update move_out: Date.strptime(row["move_out"], "%m/%d/%Y") if row["move_out"] != nil
      bulding_unit.update notes: row["notes"].to_s
    end

  end

end
