class SubsController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  before_filter :sub_exists?, only: [:edit, :update, :show]
  before_filter :user_owns_sub?, only: [:edit, :update]

  def index
    @subs = Sub.all
  end

  def new
    @sub = Sub.new
    5.times { @sub.links.new }

    render :new
  end

  def show
    render :show
  end

  def create
    @sub = current_user.subs.new(params[:sub])
    filled_out_links = params[:links].values.reject { |value| value[:url].empty? || value[:title].empty? }

    filled_out_links.each do |link_params|
      @sub.links.new(link_params.merge(user_id: current_user.id))
    end

    # @sub.save automatically performs a transaction.
    if @sub.save
      redirect_to @sub
    else
      # Ensures we have 5 links, regardless of how many links were filled out.
      # Otherwise the :new page will only have as many link fields as filled_out_links
      (5 - @sub.links.length).times { @sub.links.new }
      render :new
    end
  end

  def update
    if @sub.update_attributes(params[:sub])
      redirect_to @sub
    else
      render :edit
    end
  end

  def edit
    render :edit
  end

  private
    def user_owns_sub?
      unless @sub.moderator == current_user
        redirect_to subs_url
      end
    end

    def sub_exists?
      @sub = Sub.find_by_id(params[:id])
      redirect_to subs_url unless @sub
    end
end
