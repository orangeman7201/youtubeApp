class RepliesController < ApplicationController
  before_action :build_post, only: [:create]

  def create
    reply = @post.replies.build(reply: reply_params[:reply], user: current_user)
    if reply.save
      render status: 200
    else
      render json:{ errors: reply.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def build_post
    @post = current_user.posts.find(params[:post_id])
  end

  def reply_params
    params.fetch(:reply, {}).permit(:reply)
  end
end
