class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @link
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to new_link_comment_url(params[:link_id])
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
    params.require(:comment).permit(:body, :parent_comment_id)
  end
end

