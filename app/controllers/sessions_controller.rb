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

end

