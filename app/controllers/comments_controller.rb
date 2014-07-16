class CommentsController < ApplicationController
  before_action :require_signed_in!, only: [:new, :create]

  def create
    @comment = current_user.comments.new(comment_params)

    if @comment.save
      redirect_to link_url(@comment.link_id)
    else
      flash.now[:errors] = @comment.errors.full_messages
      redirect_to new_link_comment_url(@comment.link_id)
    end
  end

  def new
    @comment = Comment.new(link_id: params[:link_id])
    render :new
  end

  def show
    @comment = Comment.find_by_id(params[:id])
    @new_comment = Comment.new(
      link_id: @comment.link_id, parent_comment_id: @comment.id
    )

    render :show
  end

  private
  def comment_params
    params.require(:comment).permit(:body, :link_id, :parent_comment_id)
  end
end
