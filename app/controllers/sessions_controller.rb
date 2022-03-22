class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # helperに詳細記述。sessionメソッドにUser.idを渡している
      log_in(user)
      remember(user)
    else 
      render json:{ errors: user.errors.full_messages }, status: :unprocessable_entity 
    end
  end

  def destroy
    log_out
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
    if logged_in?
      render json: current_user
    else
      render json:{ errors: "ログインしていません。" }, status: :unprocessable_entity 
    end
  end

end

