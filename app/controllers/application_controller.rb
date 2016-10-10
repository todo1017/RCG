class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  before_action :get_current_user_buildings
  before_action :get_current_user_geographies

  private

  def get_current_user_buildings
    @current_user_buildings = get_all_user_buildings.map{|x| x.id}.join(', ') if current_user
  end
  def get_all_user_buildings(user=current_user)
    if user.owner_admin
      Building.where(owner_id: user.owner_id)
    else
      directly_assigned_buildings = User.where(id: user.id).joins(:user_buildings).select("user_buildings.building_id AS id")
      via_assigned_geographies = []
      via_assigned_geographies = Building.select(:id).where(competitor: false).where("geography_id IN (#{UserGeography.where(user_id: user.id, access_type: "all").pluck(:geography_id).map{|x| x.inspect}.join(', ')})") unless UserGeography.where(user_id: user.id, access_type: "all").blank?
      directly_assigned_buildings + via_assigned_geographies
    end
  end

  def get_current_user_geographies
    @current_user_geographies = get_all_user_geographies if current_user
  end
  def get_all_user_geographies(user=current_user)
    if user.owner_admin
      Geography.where(owner_id: user.owner_id).map{|x| x.id}.join(', ')
    else
      UserGeography.where(user_id: user.id).pluck(:geography_id).map{|x| x.inspect}.join(', ')
    end
  end

  def current_user
    @current_user ||= User.find_by_auth_token!(cookies[:auth_token]) if cookies[:auth_token]
  end
  helper_method :current_user

  def authorize
    redirect_to login_url, alert: "Not authorized" if current_user.nil?
  end

  def require_login
    unless current_user
      redirect_to login_url
    end
  end

end
