class UserGeographiesController < ApplicationController
  before_action :set_user_geography, only: [:show, :edit, :update, :destroy]

  # GET /user_geographies
  # GET /user_geographies.json
  def index
    @user_id = params[:user_id]
    @user_geographies = UserGeography.where(user_id: @user_id)
  end

  # GET /user_geographies/1
  # GET /user_geographies/1.json
  def show
  end

  # GET /user_geographies/new
  def new
    @user_geography = UserGeography.new
  end

  # GET /user_geographies/1/edit
  def edit
  end

  # POST /user_geographies
  # POST /user_geographies.json
  def create
    @user_geography = UserGeography.new(user_geography_params)

    respond_to do |format|
      if @user_geography.save
        format.html { redirect_to @user_geography, notice: 'User geography was successfully created.' }
        format.json { render :show, status: :created, location: @user_geography }
      else
        format.html { render :new }
        format.json { render json: @user_geography.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /user_geographies/1
  # PATCH/PUT /user_geographies/1.json
  def update
    respond_to do |format|
      if @user_geography.update(user_geography_params)
        format.html { redirect_to @user_geography, notice: 'User geography was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_geography }
      else
        format.html { render :edit }
        format.json { render json: @user_geography.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /user_geographies/1
  # DELETE /user_geographies/1.json
  def destroy
    @user_geography.destroy
    respond_to do |format|
      format.html { redirect_to user_geographies_url, notice: 'User geography was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_geography
      @user_geography = UserGeography.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_geography_params
      params.require(:user_geography).permit(:user_id, :geography_id, :access_type)
    end
end
