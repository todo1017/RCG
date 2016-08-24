class Analysis < ActiveRecord::Base

	def self.import(file)
		
		xlsx = Roo::Spreadsheet.open(file)
		
		xlsx.each_with_pagename do |sheet_name, sheet|
			
			counter = 0
			message = 'progress..'
			
			(2..sheet.last_row).each do |i|
				begin
					analysis = Analysis.new
					analysis.property     = sheet.cell("A", i).to_s if sheet.cell("A", i) != nil
					analysis.sq_feet      = sheet.cell("B", i).to_s if sheet.cell("B", i) != nil
					analysis.act_rent     = sheet.cell("C", i).to_s if sheet.cell("C", i) != nil
					analysis.months_off   = sheet.cell("D", i).to_s if sheet.cell("D", i) != nil
					analysis.cash_off     = sheet.cell("E", i).to_s if sheet.cell("E", i) != nil
					analysis.lease_length = sheet.cell("F", i).to_s if sheet.cell("F", i) != nil
					analysis.date         = sheet.cell("G", i).to_s if sheet.cell("G", i) != nil

					_date = analysis.date
					if _date.include? "/"
						date    = Date._strptime(_date,"%m/%d/%Y")
						quarter = 1 + date[:mon] / 4

						analysis.timestamp = Date.new(date[:year], date[:mon], date[:mday]).to_time.to_i
						analysis.year    = date[:year]
						analysis.quarter = "Q" + quarter.to_s + "-" + date[:year].to_s
						analysis.month   = date[:year].to_s + "-" + date[:mon].to_s
					else
						date = Date._strptime(_date,"%m-%d-%Y")
						quarter = 1 + date[:mon] / 4

						analysis.timestamp = Date.new(date[:year], date[:mon], date[:mday]).to_time.to_i
						analysis.year    = date[:year]
						analysis.quarter = "Q" + quarter.to_s + "-" + date[:year].to_s
						analysis.month   = date[:year].to_s + "-" + date[:mon].to_s
					end

					months_off   = analysis.months_off.to_f
					act_rent     = analysis.act_rent.tr(',','').to_f
					cash_off     = analysis.cash_off.to_f
					lease_length = analysis.lease_length.to_f
					if lease_length == 0.0
						lease_length = 12.0
					end
					sq_feet      = analysis.sq_feet.to_f

					analysis.gross_rent = (act_rent / sq_feet).round(2)

					if(months_off)
						analysis.net_rent = ((act_rent - ((months_off * act_rent)/lease_length.to_f))/sq_feet).round(2)
					else
						analysis.net_rent = ((act_rent - (cash_off / lease_length))/sq_feet).round(2)
					end

					analysis.save!
					counter = counter + 1
				rescue
					message = message + "< error : " + counter.to_s + ">"
					next
				end
			end

			message = message + "<total row : " + counter.to_s + ">"
			return message
		end
	end
	
end
