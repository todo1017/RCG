class BuildingOccupanciesController < ApplicationController
  before_action :set_building_occupancy, only: [:show, :edit, :update, :destroy]

  def index
    @building_occupancies_owned = BuildingOccupancy.joins(:building).where("buildings.competitor = ?", false).order("building_id, as_of_date DESC")
    @building_occupancies_comp = BuildingOccupancy.joins(:building).where("buildings.competitor = ?", true).order("building_id, as_of_date DESC")
  end

  def new
    @building_occupancy = BuildingOccupancy.new
    select_buildings
  end

  def edit
    select_buildings
  end

  def select_buildings
    if params[:competitor] == "true"
      @buildings = Building.where(competitor: true).order('name ASC')
    else
      @buildings = Building.where(competitor: false).order('name ASC')
    end
  end

  def get_redirect_path
    logger.debug params
    if params[:add_another] == "1"
      if params[:building_occupancy][:competitor] == "true"
        return new_building_occupancy_path(competitor: "true")
      else
        return new_building_occupancy_path
      end
    else
      return building_occupancies_path
    end
  end

  def create
    @building_occupancy = BuildingOccupancy.new(building_occupancy_params)

    respond_to do |format|
      if @building_occupancy.save
        format.html { redirect_to get_redirect_path, notice: 'Building occupancy was successfully created.' }
        format.json { render :show, status: :created, location: @building_occupancy }
      else
        format.html { render :new }
        format.json { render json: @building_occupancy.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @building_occupancy.update(building_occupancy_params)
        format.html { redirect_to building_occupancies_path, notice: 'Building occupancy was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_occupancy }
      else
        format.html { render :edit }
        format.json { render json: @building_occupancy.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @building_occupancy.destroy
    respond_to do |format|
      format.html { redirect_to building_occupancies_path, notice: 'Building occupancy was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_occupancy
      @building_occupancy = BuildingOccupancy.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_occupancy_params
      params.require(:building_occupancy).permit(:building_id, :occupancy_rate, :leased_rate, :as_of_date)
    end
end
