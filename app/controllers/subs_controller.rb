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
    @sub = Sub.find(params[:id])
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
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  def edit
    @sub = Sub.find(params[:id])
    render :edit
  end

  def downvote; vote(-1); end
  def upvote; vote(1); end

  private
  def require_user_owns_sub!
    return if Sub.find(params[:id]).moderator == current_user
    render json: "Forbidden", status: :forbidden
  end

  def sub_params
    params.require(:sub).permit(:name, :description)
  end

  def vote(direction)
    @sub = Sub.find(params[:id])
    @user_vote = UserVote.find_by(
      votable_id: @sub.id, votable_type: "Sub", user_id: current_user.id
    )

    if @user_vote
      @user_vote.update(value: direction)
    else
      @sub.user_votes.create!(
        user_id: current_user.id, value: direction
      )
    end

    redirect_to sub_url(@sub)
  end
end
