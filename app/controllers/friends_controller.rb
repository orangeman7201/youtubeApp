class FriendsController < ApplicationController

  def create
    Friend.create(user_id: session[:user_id], friend_user_id: params[:id])
    Friend.create(user_id: params[:id],         friend_user_id: session[:user_id])
    request = Request.find_by(from_user_id: params[:id], to_user_id: session[:user_id])
    request.destroy
  end
end
