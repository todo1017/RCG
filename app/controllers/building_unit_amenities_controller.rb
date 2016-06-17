class BuildingUnitAmenitiesController < ApplicationController
  before_action :set_building_unit_amenity, only: [:show, :edit, :update, :destroy]

  # GET /building_unit_amenities
  # GET /building_unit_amenities.json
  def index
    @building_unit_amenities = BuildingUnitAmenity.all
  end

  # GET /building_unit_amenities/1
  # GET /building_unit_amenities/1.json
  def show
  end

  # GET /building_unit_amenities/new
  def new
    @building_unit_amenity = BuildingUnitAmenity.new
  end

  # GET /building_unit_amenities/1/edit
  def edit
  end

  # POST /building_unit_amenities
  # POST /building_unit_amenities.json
  def create
    @building_unit_amenity = BuildingUnitAmenity.new(building_unit_amenity_params)

    respond_to do |format|
      if @building_unit_amenity.save
        format.html { redirect_to "/building_amenities", notice: 'Building unit amenity was successfully created.' }
        format.json { render :show, status: :created, location: @building_unit_amenity }
      else
        format.html { render :new }
        format.json { render json: @building_unit_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_unit_amenities/1
  # PATCH/PUT /building_unit_amenities/1.json
  def update
    respond_to do |format|
      if @building_unit_amenity.update(building_unit_amenity_params)
        if params[:redirect] == "false"
          format.html { redirect_to "/building_unit_amenities/#{params[:id]}/edit", notice: 'Building unit amenity was successfully updated.' }
        end
        format.html { redirect_to "/building_amenities", notice: 'Building unit amenity was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_unit_amenity }
      else
        format.html { render :edit }
        format.json { render json: @building_unit_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_unit_amenities/1
  # DELETE /building_unit_amenities/1.json
  def destroy
    @building_unit_amenity.destroy
    respond_to do |format|
      format.html { redirect_to building_unit_amenities_url, notice: 'Building unit amenity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_unit_amenity
      @building_unit_amenity = BuildingUnitAmenity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_unit_amenity_params
      params.require(:building_unit_amenity).permit(:building_id, :washer_dryer, :washer_dryer_, :microwave, :microwave_, :security_alarm, :security_alarm_, :amenity_ceiling_id, :ceiling_, :amenity_patio_id, :patio_, :oversized_windows, :oversized_windows_, :other, :other_)
    end
end
