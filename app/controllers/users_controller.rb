class UsersController < ApplicationController

  def new
  end

  def show
    user = User.find(params[:id])
    render json: user, serializer: UserSerializer
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
    if user.update(update_params)
      render json: user, serializer: UserSerializer
    else
      render json:{ errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def self
    render json: current_user, serializer: UserSerializer
  end

  def update_image
    user = User.find(params[:id])
    user.image.attach(params[:image])
    if user.save!
      render json: user, serializer: UserSerializer
    end
  end

  private

  def update_params
    params.require(:user).permit(:name, :uuid, :limit)
  end
end
