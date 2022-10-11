class FriendsController < ApplicationController
  def index
    friends ||= current_user.friends
    render json: friends, serializer: FrinedSerializer
  end

  def create
    Friend.create(user_id: current_user.id, friend_user_id: params[:id])
    Friend.create(user_id: params[:id],         friend_user_id: current_user.id)
    request = Request.find_by(from_user_id: params[:id], to_user_id: current_user.id)
    request.destroy
  end
end
