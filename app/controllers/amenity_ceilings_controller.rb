class AmenityCeilingsController < ApplicationController
  before_action :set_amenity_ceiling, only: [:show, :edit, :update, :destroy]

  # GET /amenity_ceilings
  # GET /amenity_ceilings.json
  def index
    @amenity_ceilings = AmenityCeiling.all
  end

  # GET /amenity_ceilings/1
  # GET /amenity_ceilings/1.json
  def show
  end

  # GET /amenity_ceilings/new
  def new
    @amenity_ceiling = AmenityCeiling.new
  end

  # GET /amenity_ceilings/1/edit
  def edit
  end

  # POST /amenity_ceilings
  # POST /amenity_ceilings.json
  def create
    @amenity_ceiling = AmenityCeiling.new(amenity_ceiling_params)

    respond_to do |format|
      if @amenity_ceiling.save
        format.html { redirect_to "/amenity_ceilings", notice: 'Amenity ceiling was successfully created.' }
        format.json { render :show, status: :created, location: @amenity_ceiling }
      else
        format.html { render :new }
        format.json { render json: @amenity_ceiling.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amenity_ceilings/1
  # PATCH/PUT /amenity_ceilings/1.json
  def update
    respond_to do |format|
      if @amenity_ceiling.update(amenity_ceiling_params)
        format.html { redirect_to "/amenity_ceilings", notice: 'Amenity ceiling was successfully updated.' }
        format.json { render :show, status: :ok, location: @amenity_ceiling }
      else
        format.html { render :edit }
        format.json { render json: @amenity_ceiling.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amenity_ceilings/1
  # DELETE /amenity_ceilings/1.json
  def destroy
    @amenity_ceiling.destroy
    respond_to do |format|
      format.html { redirect_to amenity_ceilings_url, notice: 'Amenity ceiling was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amenity_ceiling
      @amenity_ceiling = AmenityCeiling.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amenity_ceiling_params
      params.require(:amenity_ceiling).permit(:name)
    end
end
