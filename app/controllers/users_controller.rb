class UsersController < ApplicationController
  before_filter :authenticate_user!, only: [:show]
  before_filter :new_user?, only: [:new, :create]

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(params[:user])

    if @user.save
      login_user!(@user)
      redirect_to @user
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def show
    @user = User.find_by_id(params[:id])

    if @user
      render :show
    else
      redirect_to subs_url
    end
  end
end