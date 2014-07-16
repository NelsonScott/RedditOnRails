class SubsController < ApplicationController
  before_action :require_signed_in!, except: [:index, :show]
  before_action :require_user_owns_sub!, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def new
    @sub = Sub.new
    render :new
  end

  def show
    render :show
  end

  def create
    @sub = current_user.subs.new(sub_params)
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def update
    if sub.update(sub_params)
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def edit
    render :edit
  end

  private
  def require_user_owns_sub!
    set_sub!
    redirect_to subs_url unless sub.moderator == current_user
  end

  def set_sub!
    @sub ||= Sub.includes(:links).find(params[:id])
  end

  def sub_params
    params.require(:sub).permit(:name, links: [:url, :title, :body])
  end
end
