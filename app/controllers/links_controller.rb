class LinksController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create, :upvote, :downvote]
  before_filter :link_exists?, only: [:edit, :show, :update, :upvote, :downvote]
  before_filter :user_owns_link?, only: [:edit, :update]

  def new
    @link = Link.new
    @subs = Sub.all
  end

  def show
    render :show
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to @link
    else
      @subs = Sub.all
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def edit
    @subs = Sub.all
  end

  def update
    if @link.update_attributes(link_params)
      redirect_to @link
    else
      flash.now[:errors] = @link.errors.full_messages
      render :edit
    end
  end

  def upvote
    vote(1)
  end

  def downvote
    vote(-1)
  end

  private
    def link_exists?
      @link = Link.includes(:user_votes).find_by_id(params[:id])
      redirect_to subs_url unless @link
    end

    def vote(direction)
      @user_vote = UserVote.find_by_link_id_and_user_id(@link.id, current_user.id)

      if @user_vote
        @user_vote.value == direction ? @user_vote.update_attributes(value: 0) : @user_vote.update_attributes(value: direction)
      else
        @link.user_votes.create(user_id: current_user.id, value: direction)
      end

      redirect_to @link
    end

    def user_owns_link?
      redirect_to @link unless @link.user == current_user
    end

  private
  def link_params
    params.require(:link).permit(:url, :title, :body, :user_id, :sub_ids)
  end
end
