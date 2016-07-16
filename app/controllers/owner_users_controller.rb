class OwnerUsersController < ApplicationController

  def user_assignments
    get_index_data
  end

  def get_index_data
    @owner_user = OwnerUser.new
    @owner_users = OwnerUser.order(:user_id)
  end

  def create
    if params[:owner_user][:owner_id] == "" || params[:owner_user][:user_id] == ""
      flash[:notice] = "please make selections"
    else
      OwnerUser.create(owner_user_params)
    end
    get_index_data
    render "user_assignments"
  end

  def toggle_dpm_admin
    owner_user = OwnerUser.where(owner_id: params[:owner_id], user_id: params[:user_id]).first
    owner_user.toggle(:dpm_admin)
    owner_user.save

    get_index_data
    render "user_assignments"
  end

  def destroy
    OwnerUser.find(params[:id]).destroy
    get_index_data
    render "user_assignments"
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def owner_user_params
    params.require(:owner_user).permit(:owner_id, :user_id)
  end

end
