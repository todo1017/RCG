class BuildingsController < ApplicationController
  before_action :set_building, only: [:show, :edit, :update, :destroy]

  # GET /buildings
  # GET /buildings.json
  def index
    @buildings = Building.all
  end

  # GET /buildings/1
  # GET /buildings/1.json
  def show
  end

  # GET /buildings/new
  def new
    @building = Building.new(competitor: false)
  end

  # GET /buildings/1/edit
  def edit
    @building_occupancies = BuildingOccupancy.where(building_id: params[:id]).order("as_of_date DESC")
  end

  # POST /buildings
  # POST /buildings.json
  def create
    @building = Building.new(building_params)

    respond_to do |format|
      if @building.save
        building_fee_schedule = BuildingFeeSchedule.new
        building_fee_schedule.update_attribute :building_id, @building.id
        building_fee_schedule.save!
        building_amenity = BuildingAmenity.new
        building_amenity.update_attribute :building_id, @building.id
        building_amenity.save!
        building_unit_amenity = BuildingUnitAmenity.new
        building_unit_amenity.update_attribute :building_id, @building.id
        building_unit_amenity.save!
        format.html { redirect_to :back, notice: 'Building was successfully created.' }
        format.json { render :show, status: :created, location: @building }
      else
        format.html { render :new }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /buildings/1
  # PATCH/PUT /buildings/1.json
  def update
    respond_to do |format|
      if @building.update(building_params)
        format.html { redirect_to :back, notice: 'Building was successfully updated.' }
        format.json { render :show, status: :ok, location: @building }
      else
        format.html { render :edit }
        format.json { render json: @building.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /buildings/1
  # DELETE /buildings/1.json
  def destroy
    @building.destroy
    respond_to do |format|
      format.html { redirect_to root_path, notice: 'Building was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building
      @building = Building.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_params
      params.require(:building).permit(:owner_id, :name, :description, :comp_group_id, :phone, :manager, :manager_email, :manager_phone, :number_of_units, :website, :year_built, :year_remodeled, :geography_id, :competitor, :address1, :address2, :city, :state, :zip, :owned_by, :managed_by, :end_date)
    end
end
