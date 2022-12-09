class SessionsController < ApplicationController
  include SessionCheck

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.valid_password?(params[:session][:password])
      sign_in(user)
      remember(user)
    else 
      render json:{ errors: user.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  def destroy
    forget(current_user)
    sign_out(current_user)
  end

  def gest_login
    if user = User.find_by(email: "guest@example.com")
      sign_in(user)
      remember(user)
    else
      render json:{ errors: user.errors.full_messages }, status: :unprocessable_entity 
    end
  end
end

