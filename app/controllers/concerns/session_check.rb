module SessionCheck
  extend ActiveSupport::Concern

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
      else
        render json:{ errors: "require login" }, status: :unprocessable_entity 
      end
    end
  end

  def nothing_return_session_check
    return if current_user
    user = User.find_by(id: user_id) if user_id = cookies.encrypted[:user_id]
    sign_in(user) if user && user.authenticated?(cookies[:remember_token])
  end
end