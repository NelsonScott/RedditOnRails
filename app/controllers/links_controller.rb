class LinksController < ApplicationController
  before_action :require_signed_in!, except: [:show]
  before_action :require_user_owns_link!, only: [:edit, :update]

  def new
    @link = Link.new
    render :new
  end

  def show
    @link = Link.find(params[:id])
    render :show
  end

  def create
    @link = current_user.links.new(link_params)
    if @link.save
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :new
    end
  end

  def edit
    @link = Link.find(params[:id])
    render :edit
  end

  def update
    @link = Link.find(params[:id])
    if @link.update(link_params)
      redirect_to link_url(@link)
    else
      flash.now[:errors] = @link.errors.full_messages
      render :edit
    end
  end

  def downvote; vote(-1); end
  def upvote; vote(1); end

  private
  def link_params
    params.require(:link).permit(
      :url, :title, :body, :user_id, sub_ids: []
    )
  end

  def require_user_owns_link!
    return if Link.find(params[:id]).submitter == current_user
    render json: "Forbidden", status: :forbidden
  end

  def vote(direction)
    @link = Link.find(params[:id])
    @user_vote = UserVote.find_by(
      link_id: @link.id, user_id: current_user.id
    )

    if @user_vote
      value = @user_vote.value == direction ? 0 : direction
      @user_vote.update(value: value)
    else
      @link.user_votes.create!(
        user_id: current_user.id, value: direction
      )
    end

    redirect_to link_url(@link)
  end
end
