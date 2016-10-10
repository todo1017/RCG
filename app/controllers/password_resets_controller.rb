class PasswordResetsController < ApplicationController
  skip_filter :require_login

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_password_reset if user
    redirect_to root_url, :notice => "You will soon receive an email with password reset instructions."
  end

  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end

  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password reset has expired."
    elsif @user.update(params.require(:user).permit(:password, :password_confirmation))
      cookies[:auth_token] = @user.auth_token
      redirect_to root_url, :notice => "Welcome!"
    else
      render :edit
    end
  end
end
