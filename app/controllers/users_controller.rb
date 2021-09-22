class UsersController < ApplicationController
  def show
    # find(params)にする必要がある
    @user = User.(params[:id])
    render json: @movie
    # ↑これは必要なのか？Getリクエストの時に（user/1.jsonではないのか)
  end

  def new
  end

  def create
    new_user = User.create(name: params[:name], email: params[:email], password: params[:password], password_confirmation: params[:passwordConfirmation])
    if new_user.save
      log_in(new_user)
      remember new_user
    else
      render json:{ errors: new_user.errors.full_messages }, status: :unprocessable_entity
    end
  end

end
