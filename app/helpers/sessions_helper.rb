module SessionsHelper
  def logged_in?
    # // クッキーがDBに登録されているものと一致するか確認する
    cookies[:remember_user_token]
  end
end
