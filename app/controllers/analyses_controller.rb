class AnalysesController < ApplicationController
	
	def index
		@analyses = Analysis.all
	end

	def update
		$analyses_count = Analysis.all.count
		$competitors_count = BuildingUnit.competitors.all.count
		$same_date_count = 0
		$same_id_count   = 0
		if $analyses_count > 0
			$same_date_count = ActiveRecord::Base.connection.execute('SELECT a.id FROM analyses a, building_units b WHERE a.building_unit = b.id').count
			$same_id_count = ActiveRecord::Base.connection.execute('SELECT a.id FROM analyses a, building_units b WHERE a.building_unit = b.id and a.date = b.as_of_date').count
		end

		$new_count     = $competitors_count - $same_date_count
		$updated_count = $same_date_count - $same_id_count
		$deleted_count = $analyses_count - $same_date_count
		flash[:info] = ''
		flash[:success] = ''

		if $new_count + $updated_count + $deleted_count > 0
			flash[:info] = "Your database need update"
			flash[:success] = ''
		end
		
		if !$message.blank?
			flash[:info] = ''
			flash[:success] = $message
			$message = ''
		end
	end

	def update_data
		Analysis.destroy_all

		competitors = BuildingUnit.competitors.all
		counter = 0
		error = ''
		for competitor in competitors
			# begin
				if competitor.as_of_date
					analysis = Analysis.new
					analysis.date = competitor.as_of_date
					analysis.building_unit = competitor.id
					analysis.property = competitor.building.name

					date = analysis.date
					quarter = 1 + date.month / 4

					analysis.timestamp = date.to_time.to_i
					analysis.year    = date.year
					analysis.quarter = date.year.to_s + "-Q" + quarter.to_s
					analysis.month   = date.year.to_s + "-" + date.month.to_s

					months_off   = 0.0
					act_rent     = 0.0
					cash_off     = 0.0
					lease_length = 12.0

					if !competitor.months_off.blank?
						months_off = competitor.months_off.to_f 
					end
					if !competitor.actual_rent.blank?
						act_rent = competitor.actual_rent 
					end
					if !competitor.cash_off.blank?
						cash_off     = competitor.cash_off.to_f 
					end
					if !competitor.lease_length.blank?
						lease_length = competitor.lease_length.to_f 
					end
					
					
					sq_feet = competitor.sq_feet.to_f

					analysis.gross_rent = (act_rent / sq_feet).round(2)

					if(months_off)
						analysis.net_rent_sf = ((act_rent - ((months_off * act_rent)/lease_length))/sq_feet).round(2)
						analysis.net_rent = (act_rent - ((months_off * act_rent)/lease_length)).round(2)
					else
						analysis.net_rent_sf = ((act_rent - (cash_off / lease_length))/sq_feet).round(2)
						analysis.net_rent = (act_rent - ((months_off * act_rent)/lease_length)).round(2)
					end

					if sq_feet == 0
						analysis.gross_rent = 0
						analysis.net_rent_sf = 0
					end

					analysis.save!
				end
			# rescue
			# 	error = error + "< error >"
			# 	next
			# end
		end
		if !error.blank?
			$message = 'errors are occured'
		else
			$message = 'Successfully updated'
		end
		
		redirect_to :back
	end

	def ppsf
		@geographies = Geography.all
		@comp_groups = CompGroup.all
	end

	def net_rent_ranking
		@geographies = Geography.all
		@comp_groups = CompGroup.all
	end

	def map
	end

	def api
		type = params[:type]
		case type
		when 'ppsf_rpt'
			buildings = []
			for filter in params[:filter_list]
				ids    = filter.split("_")
				result = Building.where("geography_id = ? AND comp_group_id = ?", ids[0], ids[1])
				for r in result
					buildings.push(r[:name])
				end
			end

			gross_year    = {}
			gross_quarter = {}
			gross_month   = {}
			net_year      = {}
			net_quarter   = {}
			net_month     = {}

			for building in buildings

				gross_year_res    = Analysis.select("year as label,    avg(gross_rent) as val").where("property = ?", building).group('year').order('year')
				gross_quarter_res = Analysis.select("quarter as label, avg(gross_rent) as val").where("property = ?", building).group('quarter').order('quarter')
				gross_month_res   = Analysis.select("month as label,   avg(gross_rent) as val").where("property = ?", building).group('month').order('month')
				net_year_res      = Analysis.select("year as label,    avg(net_rent_sf)   as val").where("property = ?", building).group('year').order('year')
				net_quarter_res   = Analysis.select("quarter as label, avg(net_rent_sf)   as val").where("property = ?", building).group('quarter').order('quarter')
				net_month_res     = Analysis.select("month as label,   avg(net_rent_sf)   as val").where("property = ?", building).group('month').order('month')
				
				gross_year[building]    = gross_year_res
				gross_quarter[building] = gross_quarter_res
				gross_month[building]   = gross_month_res
				net_year[building]      = net_year_res
				net_quarter[building]   = net_quarter_res
				net_month[building]     = net_month_res

			end

			result = {
				'gross' => {
					'year'    => gross_year,
					'quarter' => gross_quarter,
					'month'   => gross_month
				},
				'net' => {
					'year'    => net_year,
					'quarter' => net_quarter,
					'month'   => net_month
				}
			}

			render json: { data: result}
		when 'ppsf_cbr'
			from_date = DateTime.parse(params[:from_date]).to_i
			to_date   = DateTime.parse(params[:to_date]).to_i

			buildings = []
			for filter in params[:filter_list]
				ids = filter.split("_")
				sql = 'select b.name as bname, g.name as gname from buildings b, geographies g where b.geography_id=g.id and g.id ='+ids[0]+' and b.comp_group_id='+ids[1]
				res = ActiveRecord::Base.connection.execute(sql)
				for r in res
					buildings.push({
						'name' => r["bname"],
						'geography' => r["gname"]
					})
				end
			end

			gross = []
			net   = []

			for building in buildings
				gross_res = Analysis.select('avg(gross_rent) as val').where('property = ? and timestamp >= ? and timestamp <= ?', building['name'], from_date, to_date)
				net_res   = Analysis.select('avg(net_rent_sf) as val').where('property = ? and timestamp >= ? and timestamp <= ?', building['name'], from_date, to_date)

				gross.push({
					'val'      => gross_res[0]["val"],
					'building' => building["name"],
					'geo'      => building["geography"]
				})

				net.push({
					'val'      => net_res[0]["val"],
					'building' => building["name"],
					'geo'      => building["geography"]
				})
			end

			result = {
				'gross' => gross,
				'net' => net
			}

			render json: { data: result }
		when 'nrr'
			buildings = []
			for filter in params[:filter_list]
				ids    = filter.split("_")
				result = Building.where("geography_id = ? AND comp_group_id = ?", ids[0], ids[1])
				for r in result
					buildings.push(r[:name])
				end
			end

			data = {}

			for building in buildings
				net_rent = Analysis.select("avg(net_rent_sf) as nrsf, avg(net_rent) as nr").where("property = ?", building)
				data[building] = net_rent
			end

			render json: { data: data}
		when 'us_states_data'
			states_json = JSON.parse(File.read('app/assets/json/county/US.json'))
			states_hash = JSON.parse(File.read('app/assets/json/states_hash.json'))
			building_data = ActiveRecord::Base.connection.execute('select b.id, b.competitor as competitor, b.name, b.units, b.year, b.city, b.state, b.addr, a.occupancy_rate, a.leased_rate from (select a.building_id as building_id, a.date as date, b.occupancy_rate as occupancy_rate, b.leased_rate as leased_rate from (select building_id, max(as_of_date) as date from building_occupancies where as_of_date is not null and building_id is not null group by building_id order by building_id) a left join building_occupancies b on a.building_id = b.building_id and a.date = b.as_of_date order by a.building_id) a, (select b.id, b.competitor, b.name as name, b.number_of_units as units, b.year_built as year, g.name as city, b.state as state, b.address1 as addr from buildings b, geographies g where b.geography_id = g.id and b.address1 is not null and b.state is not null) b where a.building_id = b.id')
			render json: {states: states_json, buildings: building_data, hash: states_hash}
		when 'us_county_data'
			state = params[:state]
			county_json = {}
			if File.exist?('app/assets/json/county/' + state +'.json')
				county_json = JSON.parse(File.read('app/assets/json/county/' + state +'.json'))
			end
			render json: {data: county_json}
		end
	end
end
