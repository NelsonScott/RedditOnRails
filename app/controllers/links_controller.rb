class LinksController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]
  before_filter :link_exists?, only: [:edit, :show, :update]
  before_filter :user_owns_link?, only: [:edit, :update]

  def new
    @link = Link.new
    @subs = Sub.all
  end

  def show
  end

  def create
    @link = current_user.links.new(params[:link])
    if @link.save
      redirect_to @link
    else
      @subs = Sub.all
      render :new
    end
  end

  def edit
    @subs = Sub.all
  end

  def update
  end

  private
    def link_exists?
      @link = Link.find_by_id(params[:id])
      redirect_to subs_url unless @link
    end

    def user_owns_link?
      redirect_to @link unless @link.user == current_user
    end
end
