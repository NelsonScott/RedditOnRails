class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:new, :create]

  def create
    @link = Link.find(params[:link_id])
    @comment = @link.comments.build(params[:comment])
    @comment.user = current_user

    if @comment.save
      redirect_to @link
    else
      redirect_to new_link_comment_url(params[:link_id])
    end
  end

  def new
    render :new
  end

  def show
    @comment = Comment.find_by_id(params[:id])
  end
end