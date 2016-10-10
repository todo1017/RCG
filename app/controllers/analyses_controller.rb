class AnalysesController < ApplicationController
	
	def index
		@analyses = Analysis.all
	end

	def update
		$analyses_count = Analysis.all.count
		$total_count = BuildingUnit.competitors.all.count + BuildingUnit.owned.all.count
		$same_date_count = 0
		$same_id_count   = 0
		if $analyses_count > 0
			$same_date_count = ActiveRecord::Base.connection.execute('SELECT a.id FROM analyses a, building_units b WHERE a.building_unit = b.id').count
			$same_id_count = ActiveRecord::Base.connection.execute('SELECT a.id FROM analyses a, building_units b WHERE a.building_unit = b.id and a.date = b.as_of_date').count
		end

		$new_count     = $total_count - $same_date_count
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

		owned = BuildingUnit.owned.all
		competitors = BuildingUnit.competitors.all
		counter = 0
		error = ''
		for own in owned
			begin
				if own.as_of_date
					analysis = Analysis.new

					analysis.date          = own.as_of_date
					analysis.building_unit = own.id
					analysis.property      = own.building.name
					analysis.owned         = true

					date = analysis.date
					quarter = 1 + date.month / 4

					analysis.timestamp = date.to_time.to_i
					analysis.year      = date.year
					analysis.quarter   = date.year.to_s + "-Q" + quarter.to_s
					analysis.month     = date.year.to_s + "-" + date.month.to_s

					months_off = own.months_off.blank? ? 0.0 : own.months_off.to_f 
					act_rent = own.actual_rent.blank? ? 0.0 : own.actual_rent
					cash_off = own.cash_off.blank? ? 0.0 : own.cash_off.to_f 
					lease_length = own.lease_length.blank? ? 12.0 : own.lease_length.to_f
										
					sq_feet = own.sq_feet.to_f

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
			rescue
				error = error + "< error >"
				next
			end
		end
		for competitor in competitors
			begin
				if competitor.as_of_date
					analysis = Analysis.new

					analysis.date          = competitor.as_of_date
					analysis.building_unit = competitor.id
					analysis.property      = competitor.building.name
					analysis.owned         = false

					date = analysis.date
					quarter = 1 + date.month / 4

					analysis.timestamp = date.to_time.to_i
					analysis.year      = date.year
					analysis.quarter   = date.year.to_s + "-Q" + quarter.to_s
					analysis.month     = date.year.to_s + "-" + date.month.to_s

					months_off = competitor.months_off.blank? ? 0.0 : competitor.months_off.to_f 
					act_rent = competitor.actual_rent.blank? ? 0.0 : competitor.actual_rent
					cash_off = competitor.cash_off.blank? ? 0.0 : competitor.cash_off.to_f 
					lease_length = competitor.lease_length.blank? ? 12.0 : competitor.lease_length.to_f
										
					sq_feet = competitor.sq_feet.to_f

					analysis.gross_rent = (act_rent / sq_feet).round(2)

					if(months_off)
						analysis.net_rent_sf = (	(act_rent - ((months_off * act_rent)/lease_length))/sq_feet).round(2)
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
			rescue
				error = error + "< error >"
				next
			end
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
				if ids[1] == 'o'
					result = Building.where("geography_id = ? AND competitor = ?", ids[0], false)
				else
					result = Building.where("geography_id = ? AND comp_group_id = ?", ids[0], ids[1])
				end
				for r in result
					buildings.push({
						'name' => r["name"],
						'id' => r["id"]
					})
				end
			end

			gross = {}
			net = {}

			for building in buildings
				gross_rent = BuildingUnit.select("avg(actual_rent/(CASE sq_feet WHEN 0 THEN 12 ELSE sq_feet END)) as val, date_part('year', as_of_date) as yy, date_part('month', as_of_date) as mm")
					.where('building_id = ? and as_of_date is not null', building['id'])
					.group('yy, mm')
					.order('yy,mm')

				net_rent = BuildingUnit.select("avg((actual_rent - (((CASE WHEN months_off IS NULL THEN 0 ELSE months_off END) * actual_rent)/(CASE WHEN lease_length IS NULL THEN 12 ELSE lease_length END)))/(CASE sq_feet WHEN 0 THEN 12 ELSE sq_feet END)) as val, date_part('year', as_of_date) as yy, date_part('month', as_of_date) as mm")
					.where('building_id = ? and as_of_date is not null', building['id'])
					.group('yy, mm')
					.order('yy,mm')

				gross[building['name']] = gross_rent
				net[building['name']] = net_rent
			end

			render json: { gross: gross, net: net}
		when 'ppsf_cbr'

			from_date = params[:from_date]
			to_date   = params[:to_date]

			buildings = []
			for geography in params[:geography_filter]
				ids = geography.split("_")
				if ids[1] == 'o'
					sql = 'select b.id as bid, b.name as bname, g.name as gname from buildings b, geographies g where b.geography_id=g.id and g.id ='+ids[0]+' and b.competitor= false'
				else
					sql = 'select b.id as bid, b.name as bname, g.name as gname from buildings b, geographies g where b.geography_id=g.id and g.id ='+ids[0]+' and b.comp_group_id='+ids[1]
				end
				
				res = ActiveRecord::Base.connection.execute(sql)
				for r in res
					buildings.push({
						'name' => r["bname"],
						'geography' => r["gname"],
						'id' => r["bid"]
					})
				end
			end

			gross = []
			net   = []

			for building in buildings
				gross_res = BuildingUnit.select('avg(actual_rent/(CASE sq_feet WHEN 0 THEN 12 ELSE sq_feet END)) as val')
					.where('building_id = ? and as_of_date >= ? and as_of_date <= ? and 
						beds >= ? and beds <= ? and 
						baths >=? and baths <=? and 
						floor >=? and floor <=? and 
						sq_feet >=? and sq_feet <= ? ',
						building['id'], from_date, to_date,
						params[:units_filter]['beds_min'],params[:units_filter]['beds_max'],
						params[:units_filter]['bath_min'],params[:units_filter]['bath_max'],
						params[:units_filter]['floor_min'],params[:units_filter]['floor_max'],
						params[:units_filter]['square_min'],params[:units_filter]['square_max'])
				net_res   = BuildingUnit.select('avg((actual_rent - (((CASE WHEN months_off IS NULL THEN 0 ELSE months_off END) * actual_rent)/(CASE WHEN lease_length IS NULL THEN 12 ELSE lease_length END)))/(CASE sq_feet WHEN 0 THEN 12 ELSE sq_feet END)) as val')
					.where('building_id = ? and as_of_date >= ? and as_of_date <= ? and
						beds >= ? and beds <= ? and 
						baths >=? and baths <=? and 
						floor >=? and floor <=? and 
						sq_feet >=? and sq_feet <= ? ',
						building['id'], from_date, to_date,
						params[:units_filter]['beds_min'],params[:units_filter]['beds_max'],
						params[:units_filter]['bath_min'],params[:units_filter]['bath_max'],
						params[:units_filter]['floor_min'],params[:units_filter]['floor_max'],
						params[:units_filter]['square_min'],params[:units_filter]['square_max'])

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
		when 'units_filter_info'
			beds_min  = BuildingUnit.select('min(beds)')
			beds_max  = BuildingUnit.select('max(beds)')
			baths_min = BuildingUnit.select('min(baths)')
			baths_max = BuildingUnit.select('max(baths)')
			floor_min = BuildingUnit.select('min(floor)')
			floor_max = BuildingUnit.select('max(floor)')
			sq_ft_min = BuildingUnit.select('min(sq_feet)')
			sq_ft_max = BuildingUnit.select('max(sq_feet)')
			render json: {beds_min:beds_min,beds_max:beds_max,baths_min:baths_min,baths_max:baths_max,floor_min:floor_min,floor_max:floor_max,sq_ft_min:sq_ft_min,sq_ft_max:sq_ft_max}
		when 'nrr'
			data = {}
			owned = {}
			for filter in params[:filter_list]
				ids = filter.split("_")
				is_owned = false
				if ids[1] == 'o'
					buildings = Building.where("geography_id = ? AND competitor = ?", ids[0], false)
					is_owned = true
				else
					buildings = Building.where("geography_id = ? AND comp_group_id = ?", ids[0], ids[1])
				end
				for building in buildings
					net_rent = BuildingUnit.select("avg((actual_rent - (((CASE WHEN months_off IS NULL THEN 0 ELSE months_off END) * actual_rent)/(CASE WHEN lease_length IS NULL THEN 12 ELSE lease_length END)))/(CASE sq_feet WHEN 0 THEN 12 ELSE sq_feet END)) as nrsf, avg(actual_rent - (((CASE WHEN months_off IS NULL THEN 0 ELSE months_off END) * actual_rent)/(CASE WHEN lease_length IS NULL THEN 12 ELSE lease_length END))) as nr")
						.where("building_id = ?", building[:id])
					data[building[:name]] = net_rent
					owned[building[:name]] = is_owned
				end
			end

			render json: { data: data, owned: owned}
		when 'building_map'
			building_data = ActiveRecord::Base.connection.execute('select b.id, b.competitor as competitor, b.name, b.units, b.year, b.city, b.state, b.addr, a.occupancy_rate, a.leased_rate from (select a.building_id as building_id, a.date as date, b.occupancy_rate as occupancy_rate, b.leased_rate as leased_rate from (select building_id, max(as_of_date) as date from building_occupancies where building_id is not null group by building_id order by building_id) a left join building_occupancies b on a.building_id = b.building_id and a.date = b.as_of_date order by a.building_id) a, (select b.id, b.competitor, b.name as name, b.number_of_units as units, b.year_built as year, g.name as city, b.state as state, b.address1 as addr from buildings b, geographies g where b.geography_id = g.id) b where a.building_id = b.id')
			render json: {buildings: building_data}
		end
	end
end
