class BuildingUnitsController < ApplicationController
  before_action :set_building_unit, only: [:show, :edit, :comp_edit, :update, :destroy]

  # GET /building_units
  # GET /building_units.json
  def index
    @building_units = BuildingUnit.owned

  end
  def comp_index
    @building_units = BuildingUnit.competitors
  end

  def rent_roll
    @building_units = BuildingUnit.where(building_id: params[:building_id].to_i)
    render :index
  end

  def comparisons
    if params[:geography_filter].present?
      @geography_id = params[:geography_filter]
    else
      @geography_id = Geography.first
    end

    building_units_owned_in_geography = BuildingUnit.joins(:building).where(buildings: {competitor: false, geography_id: @geography_id})
    if params[:vacancy_filter] == "2"
      @building_units = building_units_owned_in_geography.where(actual_rent: nil) + building_units_owned_in_geography.where(actual_rent: 0) + building_units_owned_in_geography.where("lease_expiration < current_date - interval '60 days' AND lease_expiration < current_date + interval '30 days'")
    elsif  params[:vacancy_filter] == "3"
      @building_units = building_units_owned_in_geography.where(actual_rent: nil) + building_units_owned_in_geography.where(actual_rent: 0) + building_units_owned_in_geography.where("lease_expiration < current_date - interval '60 days' AND lease_expiration < current_date + interval '60 days'")
    else
      @building_units = building_units_owned_in_geography.where(actual_rent: nil) + building_units_owned_in_geography.where(actual_rent: 0) + building_units_owned_in_geography.where("lease_expiration < current_date - interval '60 days'")
    end
  end

  def import
    BuildingUnit.import(params[:file])
    redirect_to :back, notice: "Yardi data updated"
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
    @building_unit = BuildingUnit.new
  end

  # GET /building_units/1/edit
  def edit
  end

  def comp_edit
  end

  def determine_path
    if params[:building_unit][:bed_bath] == "competitor_record"
      return "/comp_index"
    else
      return "/rent_roll/#{Building.find(params[:building_unit][:building_id])}"
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
      format.html { redirect_to building_units_url, notice: 'Building unit was successfully destroyed.' }
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
      params.require(:building_unit).permit(:number, :building_id, :unit_type_id, :sq_feet, :resident_name, :market_rent, :actual_rent, :resident_deposit, :other_deposit, :move_in, :move_out, :lease_expiration, :notes, :resident_id, :floor, :bed_bath, :beds, :baths, :months_off, :cash_off, :lease_length)
    end
end
