class OwnerUsersController < ApplicationController

  def user_assignments
    if current_user.super_admin
      @users = User.all.order(:owner_id, :email)
    elsif current_user.owner_admin
      @users = User.where(owner_id: current_user.owner_id).order(:email)
    end
    # get_index_data
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
