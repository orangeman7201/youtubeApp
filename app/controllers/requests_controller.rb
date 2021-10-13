class RequestsController < ApplicationController

  def index
    user = User.find(session[:user_id])
    requests = user.requested
    render json: requests
  end

  def create
    request = Request.new(from_user_id: session[:user_id], to_user_id: params[:id])
    request.save
  end
  
  def serch
    input_user  =  User.find_by(name: params[:userName])
    render json: input_user
  end

  def destroy
    request = Request.find_by(from_user: params[:id], to_user_id: session[:user_id])
    request.destroy
  end
  
  private
  def input_user_params
    params.fetch(:request, {}).permit(:from_user_id, :to_user_id)
  end
end
