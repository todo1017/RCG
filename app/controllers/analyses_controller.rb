class AnalysesController < ApplicationController
	
	def new
	end

	def create
		@analysis = Analysis.new(analysis_params)

		@analysis.save
		redirect_to @analysis
	end

	def index
		@analyses = Analysis.all
	end
	
	def show
		@analysis = Analysis.find(params[:id])
	end
	
	def edit
		@analysis = Analysis.find(params[:id])
	end
	
	def update
		@analysis = Analysis.find(params[:id])

		if @analysis.update(analysis_params)
			redirect_to @analysis
		else
			render 'edit'
		end
	end
	
	def destroy
		@analysis = Analysis.find(params[:id])
		@analysis.destroy

		redirect_to analyses_path
	end

	def csv
	end

	def import
		message = Analysis.import(params[:file])
		redirect_to :back, notice: message
	end

	def ppsf
		@geographies = Geography.all
		@comp_groups = CompGroup.all
	end

	def ppsf_filter1
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
			gross_year_sql    = 'select year as label,    avg(gross_rent) as val from analyses where property = "' + building + '"  group by year;'
			gross_quarter_sql = 'select quarter as label, avg(gross_rent) as val from analyses where property = "' + building + '"  group by quarter;'
			gross_month_sql   = 'select month as label,   avg(gross_rent) as val from analyses where property = "' + building + '"  group by month;'
			net_year_sql      = 'select year as label,    avg(net_rent)   as val from analyses where property = "' + building + '"  group by year;'
			net_quarter_sql   = 'select quarter as label, avg(net_rent)   as val from analyses where property = "' + building + '"  group by quarter;'
			net_month_sql     = 'select month as label,   avg(net_rent)   as val from analyses where property = "' + building + '"  group by month;'

			gross_year_res    = ActiveRecord::Base.connection.execute(gross_year_sql)
			gross_quarter_res = ActiveRecord::Base.connection.execute(gross_quarter_sql)
			gross_month_res   = ActiveRecord::Base.connection.execute(gross_month_sql)
			net_year_res      = ActiveRecord::Base.connection.execute(net_year_sql)
			net_quarter_res   = ActiveRecord::Base.connection.execute(net_quarter_sql)
			net_month_res     = ActiveRecord::Base.connection.execute(net_month_sql)

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
		# render json: { status: 'success'}
	end

	def ppsf_filter2

		from_date = DateTime.parse(params[:from_date]).to_i
		to_date   = DateTime.parse(params[:to_date]).to_i

		buildings = []
		for filter in params[:filter_list]
			ids = filter.split("_")
			sql = 'select b.name, g.name from buildings b, geographies g where b.geography_id=g.id and g.id ='+ids[0]+' and b.comp_group_id='+ids[1]
			res = ActiveRecord::Base.connection.execute(sql)
			for r in res
				buildings.push({
					'name' => r[0],
					'geography' => r[1]
				})
			end
		end

		gross = []
		net   = []

		for building in buildings
			gross_sql = 'select avg(gross_rent) as val from analyses where property = "'+building["name"]+'" and timestamp >='+from_date.to_s+' and timestamp <= '+to_date.to_s
			net_sql   = 'select avg(net_rent) as val from analyses where property = "'+building["name"]+'" and timestamp >='+from_date.to_s+' and timestamp <= '+to_date.to_s

			gross_res = ActiveRecord::Base.connection.execute(gross_sql)
			net_res   = ActiveRecord::Base.connection.execute(net_sql)

			gross.push({
				'val'      => gross_res[0][0],
				'building' => building["name"],
				'geo'      => building["geography"]
			})

			net.push({
				'val'      => net_res[0][0],
				'building' => building["name"],
				'geo'      => building["geography"]
			})
		end

		result = {
			'gross' => gross,
			'net' => net
		}

		render json: { data: result }
		# render json: { data: buildings }
	end

	private
		def analysis_params
			params.require(:analysis).permit(:property, :sq_feet, :act_rent, :months_off, :cash_off, :lease_length, :date)
		end
end
