class UsersController < ApplicationController

  def new
  end

  def show
    user = User.find(params[:id])
    render json: user
  end

  def create
    new_user = User.create(name: params["name"], email: params["email"], password: params["password"], password_confirmation: params["passwordConfirmation"])
    if new_user.save
      sign_in(new_user)
    else
      render json:{ errors: new_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    user = User.find(params[:id])
    if user.update_columns(name: params[:name], limit: params[:limit])
      render json: user
    else
      render json:{ errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def self
    render json: current_user
  end

  private

  def update_params
    params.require(:user).permit(:name, :limit)
  end
end
