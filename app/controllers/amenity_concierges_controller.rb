class AmenityConciergesController < ApplicationController
  before_action :set_amenity_concierge, only: [:show, :edit, :update, :destroy]

  # GET /amenity_concierges
  # GET /amenity_concierges.json
  def index
    @amenity_concierges = AmenityConcierge.all
  end

  # GET /amenity_concierges/1
  # GET /amenity_concierges/1.json
  def show
  end

  # GET /amenity_concierges/new
  def new
    @amenity_concierge = AmenityConcierge.new
  end

  # GET /amenity_concierges/1/edit
  def edit
  end

  # POST /amenity_concierges
  # POST /amenity_concierges.json
  def create
    @amenity_concierge = AmenityConcierge.new(amenity_concierge_params)

    respond_to do |format|
      if @amenity_concierge.save
        format.html { redirect_to "/amenity_concierges", notice: 'Amenity concierge was successfully created.' }
        format.json { render :show, status: :created, location: @amenity_concierge }
      else
        format.html { render :new }
        format.json { render json: @amenity_concierge.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amenity_concierges/1
  # PATCH/PUT /amenity_concierges/1.json
  def update
    respond_to do |format|
      if @amenity_concierge.update(amenity_concierge_params)
        format.html { redirect_to "/amenity_concierges", notice: 'Amenity concierge was successfully updated.' }
        format.json { render :show, status: :ok, location: @amenity_concierge }
      else
        format.html { render :edit }
        format.json { render json: @amenity_concierge.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amenity_concierges/1
  # DELETE /amenity_concierges/1.json
  def destroy
    @amenity_concierge.destroy
    respond_to do |format|
      format.html { redirect_to amenity_concierges_url, notice: 'Amenity concierge was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amenity_concierge
      @amenity_concierge = AmenityConcierge.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amenity_concierge_params
      params.require(:amenity_concierge).permit(:name)
    end
end
