class UsersController < ApplicationController

  before_action :require_login, except: [:new, :create]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :get_all_buildings
  before_action :get_all_geographies

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.active = true
    if @user.save
      session[:user_id] = @user.id
      redirect_to user_assignments_path, notice: "User Account created"
    else
      render "new"
    end
  end

  def index
    @users = User.where(owner_id: current_user.owner_id).order(:id)
  end

  def edit
  end

  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to user_assignments_path, notice: 'User was successfully updated' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @user.destroy
    redirect_to user_assignments_path, notice: 'User was successfully deleted'
  end

  def user_buildings
    respond_to do |format|
      format.html{
        @user = User.find(params[:user_id])
        @dpm_admin = @user.owner_admin
      }
      format.js{
        if params[:geography_id].present?
          UserGeography.destroy_all(user_id: params[:user_id], geography_id: params[:geography_id])
          if params[:selection] == "none"
            render partial: "/users/buildings", locals: { user_id: params[:user_id], geography_id: params[:geography_id], access_type: "none" }
          elsif params[:selection] == "partial"
            UserGeography.find_or_create_by(user_id: params[:user_id], geography_id: params[:geography_id], access_type: "partial")
            render partial: "/users/buildings", locals: { user_id: params[:user_id], geography_id: params[:geography_id], access_type: "partial" }
          elsif params[:selection] == "all"
            UserGeography.find_or_create_by(user_id: params[:user_id], geography_id: params[:geography_id], access_type: "all")
            render partial: "/users/buildings", locals: { user_id: params[:user_id], geography_id: params[:geography_id], access_type: "all" }
          end
        elsif params[:building_id].present?
          user_buildings = UserBuilding.find_by(user_id: params[:user_id], building_id: params[:building_id])
          if user_buildings == nil
            UserBuilding.create(user_id: params[:user_id], building_id: params[:building_id])
          else
            user_buildings.destroy
          end
        elsif params[:owner_id].present?
          user = User.find(params[:user_id])
          user.update_attributes owner_id: params[:owner_id]
          user.save
        else
          user = User.find(params[:user_id])
          user.toggle(:owner_admin)
          user.save
          render partial: "/users/geographies", locals: { dpm_admin: user.owner_admin, owner_id: user.owner_id, user_id: user.id }
        end
      }
    end
  end


  def toggle_super_admin
    @user = User.find(params[:id])
    @user.toggle!(:super_admin)
    @user.toggle!(:owner_admin) if @user.owner_admin == true
    @user.toggle!(:pm_admin) if @user.pm_admin == true
    if @user.save
      redirect_to :back, notice: 'Super Admin changed'
    else
      redirect_to :back, notice: 'Super Admin NOT changed'
    end
  end
  def toggle_owner_admin
    @user = User.find(params[:id])
    @user.toggle!(:owner_admin)
    @user.toggle!(:super_admin) if @user.super_admin == true
    @user.toggle!(:pm_admin) if @user.pm_admin == true
    if @user.save
      redirect_to :back, notice: 'Admin settings changed'
    else
      redirect_to :back, notice: 'Admin settings NOT changed'
    end
  end
  def toggle_pm_admin
    @user = User.find(params[:id])
    @user.toggle!(:pm_admin)
    @user.toggle!(:super_admin) if @user.super_admin == true
    @user.toggle!(:owner_admin) if @user.owner_admin == true
    if @user.save
      redirect_to :back, notice: 'Admin settings changed'
    else
      redirect_to :back, notice: 'Admin settings NOT changed'
    end
  end


  private

  def get_all_buildings
    @user_buildings = get_all_user_buildings(User.find(params[:user_id].to_i)).map{|x| x.id}.join(', ') if params[:user_id] != nil
  end
  def get_all_geographies
    @user_geographies = get_all_user_geographies(User.find(params[:user_id].to_i)) if params[:user_id] != nil
  end

  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :owner_id, :password, :password_confirmation, :approved, :owner_admin, :active, :first_name, :last_name)
  end


end
