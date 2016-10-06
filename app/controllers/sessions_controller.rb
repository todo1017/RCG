class SessionsController < ApplicationController
  skip_filter :require_login

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      notice = "Logged in!"
      if !user.active
        notice = "Account deactivated"
      elsif params[:remember_me]
        cookies.permanent[:auth_token] = user.auth_token
      else
        cookies[:auth_token] = user.auth_token
      end
      redirect_to root_url, notice: notice
    else
      flash.now.alert = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    cookies.delete(:auth_token)
    redirect_to root_url, notice: "Logged out!"
  end


end
