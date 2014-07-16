class CommentsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create]

  def create
    @link = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to link_url(@current.link_id)
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_link_comment_url(@comment.link_id)
    end
  end

  def new
    render :new
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    if @comment
      render :show
    else
      redirect_to subs_url
    end
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :link_id, :parent_comment_id)
  end
end
