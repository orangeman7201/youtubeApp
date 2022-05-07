class RequestsController < ApplicationController

  def index
    requests = current_user.requested
    render json: requests
  end

  def create
    request = Request.new(from_user_id: current_user.id, to_user_id: params[:id])
    request.save
  end
  
  def serch
    input_user  =  User.find_by(name: params[:userName])
    render json: input_user
  end

  def destroy
    request = Request.find_by(from_user: params[:id], to_user_id: current_user.id)
    request.destroy
  end
  
  private
  def input_user_params
    params.fetch(:request, {}).permit(:from_user_id, :to_user_id)
  end
end
