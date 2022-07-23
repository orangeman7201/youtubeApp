class PostsController < ApplicationController
before_action :find_post, only: [:update]

  def index
    render json: { user: current_user, posts: current_user.posts.limit(7).reverse }
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save
      render status: 200
    else
      render json:{ errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @post.update_attributes(update_params)
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:comment)
  end

  def update_params
    params.fetch(:update, {}).permit(:comment)
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end
end
