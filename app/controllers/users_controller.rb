class UsersController < ApplicationController
# before_action :authenticate_user!

  def show
    @user = User.find_by(username: params[:username])
    respond_to do |format|
      format.html
      format.json { render json: {'user': @user} }
    end
  end

  def top_users
    @users = User.left_joins(links: [:votes]).group(:id).order('COUNT(votes.upvote) DESC').limit(10)
  end

end