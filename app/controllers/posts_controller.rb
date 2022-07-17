class PostsController < ApplicationController
  def index
    render json: current_user.posts
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render status: 200
    else
      render json:{ errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:comment)
  end
end
