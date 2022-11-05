class RequestsController < ApplicationController

  def index
    debugger
    requests = current_user.requested
    render json: requests, each_serializer: RequestSerializer
  end

  def create
    request = Request.new(from_user_id: current_user.id, to_user_id: params[:id])
    request.save
  end
  
  def serch
    if serched_user = User.find_by(uuid: params[:uuid])
      render json: serched_user, serializer: RequestSerializer
    else 
      render json: { error: 'user not found' }, status: 404
    end
  end

  def destroy
    request = Request.find_by(from_user: params[:id], to_user_id: current_user.id)
    request.destroy
  end
end
