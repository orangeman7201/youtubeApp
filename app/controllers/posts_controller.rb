class PostsController < ApplicationController
before_action :find_post, only: [:update]

  def index
    render json: current_user.posts.last(7).reverse, each_serializer: PostSerializer
  end

  def create
    post = current_user.posts.build(post_params)
    if post.save!
      render json: post
    else
      render json:{ errors: post.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    @post.update(post_params)
  end

  private

  def post_params
    params.fetch(:post, {}).permit(:comment)
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end
end
