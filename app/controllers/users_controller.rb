class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_login, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_url, notice: "Thank you for signing up!"
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
        format.html { redirect_to "/users", notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
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
  def set_user
    @user = User.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:email, :owner_id, :password, :password_confirmation, :approved)
  end


end
