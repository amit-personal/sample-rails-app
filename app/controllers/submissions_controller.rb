class SubmissionsController < ApplicationController
  # before_action :authenticate_user!
  include ApplicationHelper

  def index
    user_id = User.find_by(username: params[:id])
    @links = Link.hottest.where(user_id: user_id).page(params[:page]).per(20)
    # @links = Link.where("LOWER(title) LIKE ? or LOWER(description) LIKE ? or LOWER(url) LIKE ?", "%#{params[:q].downcase}%", "%#{params[:q]}%", "%#{params[:q]}%").page(params[:page]).per(20) if params[:q].present?
    @links = filtered_links if params[:q].present?
  end
end