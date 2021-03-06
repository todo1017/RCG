class BuildingUnitsController < ApplicationController
  before_action :set_building_unit, only: [:show, :edit, :comp_edit, :update, :destroy]

  # GET /building_units
  # GET /building_units.json
  def index
    @building_units = BuildingUnit.owned

  end
  def comp_index
    @building_units = BuildingUnit.competitors.where("buildings.geography_id IN (#{@current_user_geographies})")
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def rent_roll
    if BuildingUnit.where(building_id: params[:building_id].to_i).count == 0
      @building_units = []
    else
      if params[:import_number_filter].present?
        @import_number = params[:import_number_filter]
      else
        @import_number = BuildingUnit.where(building_id: params[:building_id].to_i).order("import_number").last.import_number
      end
      # Sort method incluenced by:
      # http://stackoverflow.com/questions/6277127/sort-string-containing-numbers-in-ruby-rails/6277274#6277274
      @building_units = BuildingUnit.where(import_number: @import_number, building_id: params[:building_id].to_i).sort{|a, b| a.number.to_i <=> b.number.to_i}
    end
    render :index
  end

  def comparisons
    if params[:geography_filter].present?
      @geography_id = params[:geography_filter]
    else
      @geography_id = Geography.first
    end
    if params[:comp_filter].present?
      @comp_filter = params[:comp_filter]
    else
      @comp_filter = "29"
    end
    @compgroups = CompGroup.all

    building_units_owned_in_geography = BuildingUnit.joins(:building).where("buildings.id IN (#{@current_user_buildings})").where(buildings: {competitor: false, geography_id: @geography_id}).where("relevant_start_date = ? AND relevant_end_date = ?", Date.strptime("01/01/1910", "%m/%d/%Y"), Date.strptime("12/31/2090", "%m/%d/%Y")).order("buildings.name, building_units.floor, building_units.beds, building_units.baths")
    if params[:vacancy_filter] == "2"
      interval =  " + interval '30 days'"
    elsif  params[:vacancy_filter] == "3"
      interval =  " + interval '60 days'"
    elsif  params[:vacancy_filter] == "4"
      interval =  " + interval '90 days'"
    elsif  params[:vacancy_filter] == "5"
      interval =  " + interval '120 days'"
    else
      interval = ""
    end
    # @building_units = building_units_owned_in_geography.where(actual_rent: 0).to_a
    @building_units = (building_units_owned_in_geography.where(actual_rent: 0) + building_units_owned_in_geography.where("lease_expiration > current_date - interval '100 days' AND lease_expiration < current_date" + interval)).uniq
    @building_units.sort_by! do |x|
      date = if x.lease_expiration == nil || x.actual_rent == 0
               Date.today
             else
               x.lease_expiration
             end
      [x.building_id, date]
    end
    respond_to do |format|
      format.html
      format.xls
    end
  end

  def import
    message = BuildingUnit.import(params[:file], params[:building_id])
    redirect_to :back, notice: message
  end
  def import_yardi_1
    if params[:building][:id].present? && params[:file].present?
      message = BuildingUnit.import_yardi_1(params[:file], params[:building][:id], params[:as_of_date], params[:months_off], params[:cash_off], params[:lease_length], params[:lease_end_date])
    else
      message = "Yardi Import - Please choose a File and Building"
    end
    redirect_to :back, notice: message
  end

  # GET /building_units/1
  # GET /building_units/1.json
  def show
  end

  # GET /building_units/new
  def new
    @building_unit = BuildingUnit.new
  end
  def comp_new
    @building_unit = BuildingUnit.new(:building_id => params[:building_id])
  end

  # GET /building_units/1/edit
  def edit
  end

  def comp_edit
  end

  def determine_path
    if params[:building_unit][:bed_bath] == "competitor_record"
      if params[:building_unit][:move_in] == "1"
        return "/comp_new?building_id=#{params[:building_unit][:building_id]}"
      else
        return "/comp_index"
      end
    else
      return "/rent_roll/#{params[:building_unit][:building_id]}"
    end
  end

  # POST /building_units
  # POST /building_units.json
  def create
    @building_unit = BuildingUnit.new(building_unit_params)

    path = determine_path

    respond_to do |format|
      if @building_unit.save
        format.html { redirect_to path, notice: 'Building unit was successfully created.' }
        format.json { render :show, status: :created, location: @building_unit }
      else
        format.html { render :comp_new }
        format.json { render json: @building_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_units/1
  # PATCH/PUT /building_units/1.json
  def update
    path = determine_path

    respond_to do |format|
      if @building_unit.update(building_unit_params)
        format.html { redirect_to path, notice: 'Building unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_unit }
      else
        format.html { render :comp_edit }
        format.json { render json: @building_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_units/1
  # DELETE /building_units/1.json
  def destroy
    @building_unit.destroy
    respond_to do |format|
      format.html { redirect_to :back, notice: 'Building unit was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_unit
      @building_unit = BuildingUnit.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_unit_params
      params.require(:building_unit).permit(:number, :building_id, :unit_type_id, :sq_feet, :resident_name, :market_rent, :actual_rent, :resident_deposit, :other_deposit, :move_in, :move_out, :lease_expiration, :notes, :resident_id, :floor, :bed_bath, :beds, :baths, :add_room, :months_off, :cash_off, :lease_length, :as_of_date, :lease_end_date)
    end
end
