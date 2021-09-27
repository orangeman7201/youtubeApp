class FriendsController < ApplicationController
  def index
    user = User.find(session[:user_id])
    friends = user.friends
    render json: friends
  end

  def create
    Friend.create(user_id: session[:user_id], friend_user_id: params[:id])
    Friend.create(user_id: params[:id],         friend_user_id: session[:user_id])
    request = Request.find_by(from_user_id: params[:id], to_user_id: session[:user_id])
    request.destroy
  end
end
