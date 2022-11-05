class FriendsController < ApplicationController
  def index
    friends ||= current_user.friends
    render json: friends, each_serializer: FriendSerializer
  end

  def create
    debugger
    if request = Request.find_by(from_user_id: params[:id], to_user_id: current_user.id)
      Friend.create(user_id: current_user.id, friend_user_id: params[:id])
      Friend.create(user_id: params[:id],         friend_user_id: current_user.id)
      request.destroy
    else 
      render json: { errors: [exception] }, status: 404
    end
  end
end
