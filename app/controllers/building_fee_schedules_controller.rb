class BuildingFeeSchedulesController < ApplicationController
  before_action :set_building_fee_schedule, only: [:show, :edit, :update, :destroy]

  # GET /building_fee_schedules
  # GET /building_fee_schedules.json
  def index
    @building_fee_schedules = BuildingFeeSchedule.all
  end

  # GET /building_fee_schedules/1
  # GET /building_fee_schedules/1.json
  def show
  end

  # GET /building_fee_schedules/new
  def new
    @building_fee_schedule = BuildingFeeSchedule.new
  end

  # GET /building_fee_schedules/1/edit
  def edit
  end

  # POST /building_fee_schedules
  # POST /building_fee_schedules.json
  def create
    @building_fee_schedule = BuildingFeeSchedule.new(building_fee_schedule_params)

    respond_to do |format|
      if @building_fee_schedule.save
        format.html { redirect_to "/building_fee_schedules", notice: 'Building fee schedule was successfully created.' }
        format.json { render :show, status: :created, location: @building_fee_schedule }
      else
        format.html { render :new }
        format.json { render json: @building_fee_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /building_fee_schedules/1
  # PATCH/PUT /building_fee_schedules/1.json
  def update
    respond_to do |format|
      if @building_fee_schedule.update(building_fee_schedule_params)
        format.html { redirect_to "/building_fee_schedules", notice: 'Building Fee Schedule was successfully updated.' }
        format.json { render :show, status: :ok, location: @building_fee_schedule }
      else
        format.html { render :edit }
        format.json { render json: @building_fee_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /building_fee_schedules/1
  # DELETE /building_fee_schedules/1.json
  def destroy
    @building_fee_schedule.destroy
    respond_to do |format|
      format.html { redirect_to building_fee_schedules_url, notice: 'Building fee schedule was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_building_fee_schedule
      @building_fee_schedule = BuildingFeeSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def building_fee_schedule_params
      params.require(:building_fee_schedule).permit(:building_id, :parking, :parking_, :parking_extra, :parking_extra_, :security_deposit, :security_deposit_, :amenity_fee, :amenity_fee_, :trash_fee, :trash_fee_, :pet_deposit, :pet_deposit_, :pet_dog, :pet_dog_, :pet_cat, :pet_cat_, :application_fee, :application_fee_, :minimum_lease, :minimum_lease_, :monthly_fees, :monthly_fees_, :yearly_fees, :yearly_fees_)
    end
end
