class GeographiesController < ApplicationController
  before_action :set_geography, only: [:show, :edit, :update, :destroy]

  # GET /geographies
  # GET /geographies.json
  def index
    @geographies = Geography.all
  end

  # GET /geographies/1
  # GET /geographies/1.json
  def show
  end

  # GET /geographies/new
  def new
    @geography = Geography.new
  end

  # GET /geographies/1/edit
  def edit
  end

  # POST /geographies
  # POST /geographies.json
  def create
    @geography = Geography.new(geography_params)

    respond_to do |format|
      if @geography.save
        format.html { redirect_to "/geographies", notice: 'Geography was successfully created.' }
        format.json { render :show, status: :created, location: @geography }
      else
        format.html { render :new }
        format.json { render json: @geography.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /geographies/1
  # PATCH/PUT /geographies/1.json
  def update
    respond_to do |format|
      if @geography.update(geography_params)
        format.html { redirect_to "/geographies", notice: 'Geography was successfully updated.' }
        format.json { render :show, status: :ok, location: @geography }
      else
        format.html { render :edit }
        format.json { render json: @geography.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /geographies/1
  # DELETE /geographies/1.json
  def destroy
    @geography.destroy
    respond_to do |format|
      format.html { redirect_to geographies_url, notice: 'Geography was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_geography
      @geography = Geography.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def geography_params
      params.require(:geography).permit(:name, :owner_id)
    end
end
