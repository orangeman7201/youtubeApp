class RequestsController < ApplicationController

  def index
    user = User.find(session[:user_id])
    requests = user.requested
    render json: requests
  end

  def create
    # ワンちゃんVueのデータ名とRequestのFormUserIdの名称が一致していないとダメやった気がするので後で確認
    request = Request.new(from_user_id: session[:user_id], to_user_id: params[:id])
    request.save
  end
  
  def serch
    input_user  =  User.find_by(id: params[:userId])
    render json: input_user
  end

  def destroy
    request = Request.find_by(from_user: params[:id], to_user_id: session[:user_id])
    request.destroy
  end
  
  private
  def input_user_params
    # ワンちゃんVueのデータ名とRequestのFormUserIdの名称が一致していないとダメやった気がするので後で確認
    # 最終的にIDじゃなくてユーザー名にするから宜しく→めんどくさいから最初からNameでやれや→いやUserNameかぶったときの処理めんどくさいからよろしく
      params.fetch(:request, {}).permit(:from_user_id, :to_user_id)
    end
end
