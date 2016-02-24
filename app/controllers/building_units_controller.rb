class BuildingUnitsController < ApplicationController
  before_action :set_building_unit, only: [:show, :edit, :update, :destroy]

  # GET /building_units
  # GET /building_units.json
  def index
    @building_units = BuildingUnit.all
  end

  def rent_roll
    @building_units = BuildingUnit.where(building_id: params[:building_id].to_i)
    render :index
  end

  def comparisons
    @building_units = BuildingUnit.where(actual_rent: nil)
  end

  def import
    BuildingUnit.import(params[:file])
    redirect_to "/rent_roll/#{params[:building_id].to_i}", notice: "Yardi data updated"
  end

  # GET /building_units/1
  # GET /building_units/1.json
  def show
  end

  # GET /building_units/new
  def new
    @building_unit = BuildingUnit.new
  end

  # GET /building_units/1/edit
  def edit
  end

  # POST /building_units
  # POST /building_units.json
  def create
    @building_unit = BuildingUnit.new(building_unit_params)

    respond_to do |format|
      if @building_unit.save
        format.html { redirect_to @building_unit, notice: 'Building unit was successfully created.' }
        format.json { render :show, status: :created, location: @building_unit }
      else
        format.html { render :new }
        format.json { render json: @building_unit.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_units/1
  # PATCH/PUT /building_units/1.json
  def update
    respond_to do |format|
      if @building_unit.update(building_unit_params)
        format.html { redirect_to "/rent_roll/#{@building_unit.building_id.to_i}", notice: 'Building unit was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_unit }
      else
        format.html { render :edit }
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
      params.require(:building_unit).permit(:number, :building_id, :unit_type_id, :sq_feet, :resident_name, :market_rent, :actual_rent, :resident_deposit, :other_deposit, :move_in, :move_out, :lease_expiration, :notes, :resident_id, :floor, :bed_bath, :beds, :baths)
    end
end
