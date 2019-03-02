class CommentsController < ApplicationController
	before_action :authenticate_user!, except: :index
  before_action :set_variables, only: [:edit, :update, :destroy]
  include CommentsHelper

  def index
    @page = (params[:page].present? ? (params[:page].to_i - 1) : 0)
    @comments = Comment.where(parent_id: nil).page(params[:page]).per(20)
    @comments = filtered_comments if params[:q].present?
  end

  def edit
    unless current_user.owns_comment?(@comment)
      redirect_to root_path, notice: 'Not authorized to edit this comment'
    end
  end

  def create
    if params[:comment_new] && params[:comment_new][:parent_id].to_i > 0
      parent = Comment.find_by_id(params[:comment_new].delete(:parent_id))
      @link = Link.find_by(id: params[:comment_new][:link_id])
      @comment = parent.children.build(child_comment_params.merge!(:user => current_user, :link => @link))
    else
      @comment = Comment.new(comment_params)
      @link = Link.find_by(id: params[:link_id])
      @comment = @link.comments.new(user: current_user, body: comment_params[:body])
    end

    if @comment.save
      redirect_to @link, notice: 'Comment created'
    else
      redirect_to @link, notice: 'Comment was not saved. Ensure you have entered a comment'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @link, notice: 'Comment updated'
    else
      render :edit
    end
  end

  def destroy
    if current_user.owns_comment?(@comment)
      @comment.destroy
      redirect_to @link, notice: 'Comment deleted'
    else
      redirect_to @link, notice: 'Not authorized to delete this comment'
    end
  end

  def upvote
    comment = Comment.find_by(id: params[:id])

    # if current_user.upvoted?(comment)
    #   current_user.remove_vote(comment)
    # elsif current_user.downvoted?(comment)
    #   current_user.remove_vote(comment)
    #   current_user.upvote(comment)
    # else
    #   current_user.upvote(comment)
    # end

    redirect_to comments_path
  end

  def new
    @comment = Comment.find_by(id: params[:comment_id])
    @comment_new = Comment.new(parent_id: params[:comment_id], link_id: @comment.link_id)
  end

  def threads
    user_id = User.find_by(username: params[:id])
    @comments = Comment.where(user_id: user_id)
    @comments = @comments.hash_tree
  end

  private

  def set_variables
    @link = Link.find_by(id: params[:link_id])
    @comment = @link.comments.find_by(id: params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
  def child_comment_params
    params.require(:comment_new).permit(:body, :user_id, :parent_id)
  end
end
