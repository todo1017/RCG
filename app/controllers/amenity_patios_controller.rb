class AmenityPatiosController < ApplicationController
  before_action :set_amenity_patio, only: [:show, :edit, :update, :destroy]

  # GET /amenity_patios
  # GET /amenity_patios.json
  def index
    @amenity_patios = AmenityPatio.all
  end

  # GET /amenity_patios/1
  # GET /amenity_patios/1.json
  def show
  end

  # GET /amenity_patios/new
  def new
    @amenity_patio = AmenityPatio.new
  end

  # GET /amenity_patios/1/edit
  def edit
  end

  # POST /amenity_patios
  # POST /amenity_patios.json
  def create
    @amenity_patio = AmenityPatio.new(amenity_patio_params)

    respond_to do |format|
      if @amenity_patio.save
        format.html { redirect_to @amenity_patio, notice: 'Amenity patio was successfully created.' }
        format.json { render :show, status: :created, location: @amenity_patio }
      else
        format.html { render :new }
        format.json { render json: @amenity_patio.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amenity_patios/1
  # PATCH/PUT /amenity_patios/1.json
  def update
    respond_to do |format|
      if @amenity_patio.update(amenity_patio_params)
        format.html { redirect_to @amenity_patio, notice: 'Amenity patio was successfully updated.' }
        format.json { render :show, status: :ok, location: @amenity_patio }
      else
        format.html { render :edit }
        format.json { render json: @amenity_patio.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amenity_patios/1
  # DELETE /amenity_patios/1.json
  def destroy
    @amenity_patio.destroy
    respond_to do |format|
      format.html { redirect_to amenity_patios_url, notice: 'Amenity patio was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amenity_patio
      @amenity_patio = AmenityPatio.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amenity_patio_params
      params.require(:amenity_patio).permit(:name)
    end
end
