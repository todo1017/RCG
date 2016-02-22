class BuildingAmenitiesController < ApplicationController
  before_action :set_building_amenity, only: [:show, :edit, :update, :destroy]

  # GET /building_amenities
  # GET /building_amenities.json
  def index
    @building_amenities = BuildingAmenity.all
  end

  # GET /building_amenities/1
  # GET /building_amenities/1.json
  def show
  end

  # GET /building_amenities/new
  def new
    @building_amenity = BuildingAmenity.new
  end

  # GET /building_amenities/1/edit
  def edit
  end

  # POST /building_amenities
  # POST /building_amenities.json
  def create
    @building_amenity = BuildingAmenity.new(building_amenity_params)

    respond_to do |format|
      if @building_amenity.save
        format.html { redirect_to @building_amenity, notice: 'Building amenity was successfully created.' }
        format.json { render :show, status: :created, location: @building_amenity }
      else
        format.html { render :new }
        format.json { render json: @building_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_amenities/1
  # PATCH/PUT /building_amenities/1.json
  def update
    respond_to do |format|
      if @building_amenity.update(building_amenity_params)
        format.html { redirect_to "/building_amenities", notice: 'Building amenity was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_amenity }
      else
        format.html { render :edit }
        format.json { render json: @building_amenity.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_amenities/1
  # DELETE /building_amenities/1.json
  def destroy
    @building_amenity.destroy
    respond_to do |format|
      format.html { redirect_to building_amenities_url, notice: 'Building amenity was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_amenity
      @building_amenity = BuildingAmenity.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_amenity_params
      params.require(:building_amenity).permit(:building_id, :business_center, :business_center_, :resident_lounge, :resident_lounge_, :screening_room, :screening_room_, :rooftop_deck, :rooftop_deck_, :train_station, :train_station_, :pool, :pool_, :gated, :gated_, :amenity_concierge_id, :concierge_, :recreation, :recreation_, :fitness, :fitness_, :other, :amenity_1, :amenity_1_, :amenity_1_name, :amenity_2, :amenity_2_, :amenity_2_name, :amenity_3, :amenity_3_, :amenity_3_name, :amenity_11, :amenity_11_, :amenity_11_name, :amenity_12, :amenity_12_, :amenity_12_name)
    end
end
