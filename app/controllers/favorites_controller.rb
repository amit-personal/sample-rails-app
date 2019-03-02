class FavoritesController < ApplicationController
  # before_action :authenticate_user!
  include ApplicationHelper

  def index
    user_id = User.find_by(username: params[:id])
    vote_ids = Vote.where(user_id: user_id, upvote: 1).map(&:link_id)
    @links = Link.hottest.where(id: vote_ids).page(params[:page]).per(20)
    # @links = Link.where("LOWER(title) LIKE ? or LOWER(description) LIKE ? or LOWER(url) LIKE ?", "%#{params[:q].downcase}%", "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page]).per(20) if params[:q].present?
    @links = filtered_links if params[:q].present?
  end
end