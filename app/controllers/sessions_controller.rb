class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_name(params[:user][:name])
    if @user && @user.is_password?(params[:user][:password])
      login_user!(@user)
      redirect_to @user
    else
      flash[:errors] << "Invalid username or password."

      @user ||= User.new
      render :new
    end
  end

  def destroy
    current_user && current_user.reset_session_token!
    session[:token] = nil

    redirect_to new_session_url
  end
end