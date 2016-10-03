class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :require_login

  before_action :get_current_user_buildings

  private

  def get_current_user_buildings
    @current_user_buildings = get_all_user_buildings.map{|x| x.id}.join(', ') if current_user
  end

  def get_all_user_buildings(user=current_user)
    if user.owner_admin
      Building.where(owner_id: user.owner_id)
    else
      User.where(id: user.id).joins(:user_buildings).select("user_buildings.building_id AS id") + Building.select(:id).where("geography_id IN (#{UserGeography.where(user_id: user.id, access_type: "all").pluck(:geography_id).map{|x| x.inspect}.join(', ')})")
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
