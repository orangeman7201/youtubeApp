class SessionsController < ApplicationController

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
    user = User.find_by(email: "gest@example.com")
    if user
      log_in(user)
    else
      render json:{ errors: user.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  def session_check
    if current_user
      render json: current_user
    else
      if user_id = cookies.encrypted[:user_id]
      user = User.find_by(id: user_id)
        if user && user.authenticated?(cookies[:remember_token])
          sign_in(user)
          render json: current_user, serializer: UserSerializer
        end
      end
    end
  end
end

