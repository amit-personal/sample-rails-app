class LinksController < ApplicationController
	before_action :authenticate_user!, except: [:show, :index, :newest]
  include ApplicationHelper

  def index
    @page = (params[:page].present? ? (params[:page].to_i - 1) : 0)
    #@links = Link.hottest.limit(20).offset(@page * 20)
    @links = Link.hottest.page(params[:page]).per(20)
    @links = Link.where("url LIKE ?", "%#{params[:site]}%").page(params[:page]).per(20) if params[:site].present?
    # @links = Link.where("LOWER(title) LIKE ? or LOWER(description) LIKE ? or LOWER(url) LIKE ?", "%#{params[:q].downcase}%", "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page]).per(20) if params[:q].present?
    @links = filtered_links if params[:q].present?
    # @total_page = (Link.hottest.count.to_i / 20).round
    # puts @total_page
  end

  def newest
    @page = (params[:page].present? ? (params[:page].to_i - 1) : 0)
    @links = Link.newest.page(params[:page]).per(20)
    # @links = Link.where("LOWER(title) LIKE ? or LOWER(description) LIKE ? or LOWER(url) LIKE ?", "%#{params[:q].downcase}%", "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page]).per(20) if params[:q].present?
    @links = filtered_links if params[:q].present?
  end

  def new
    @link = Link.new
  end

  def show
    @link = Link.find_by(id: params[:id])
    @comments = @link.comments.hash_tree
  end

  def edit
    perform_action(:edit) { |link| @link = link }
  end

  def update
    @link = current_user.links.find_by(id: params[:id])

    if @link.update(link_params)
      redirect_to root_path, notice: 'Link successfully updated'
    else
      render :edit
    end
  end

  def create
    @link = current_user.links.new(link_params)

    if @link.save
      current_user.upvote(@link)
      @link.calc_hot_score
      redirect_to root_path, notice: 'Link successfully created'
    else
      render :new
    end
  end

  def destroy
    perform_action(:delete) do |link|
      link.destroy
      redirect_to root_path, notice: 'Link successfully deleted'
    end
  end

  def upvote
    link = Link.find_by(id: params[:id])

    if current_user.upvoted?(link)
      current_user.remove_vote(link)
    elsif current_user.downvoted?(link)
      current_user.remove_vote(link)
      current_user.upvote(link)
    else
      current_user.upvote(link)
    end

    link.calc_hot_score
    redirect_to root_path
  end

  def downvote
    link = Link.find_by(id: params[:id])

    if current_user.downvoted?(link)
      current_user.remove_vote(link)
    elsif current_user.upvoted?(link)
      current_user.remove_vote(link)
      current_user.downvote(link)
    else
      current_user.downvote(link)
    end

    link.calc_hot_score
    redirect_to root_path
  end

  private

  def perform_action(action)
    link = Link.find_by(id: params[:id])

    if current_user.owns_link?(link)
      yield(link) if block_given?
    else
      redirect_to root_path, notice: "Not authorized to #{action} this link"
    end
  end

  def link_params
    params.require(:link).permit(:title, :url, :description)
  end
end
