class PostsController < ApplicationController
before_action :find_post, only: [:update]

  def index
    render json: resource, each_serializer: PostSerializer
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
  
  def resource
    resource = current_user.id
    resource = current_user.friends.ids if params.include?("friend")
    resource = Post.where(user_id: resource).order(created_at: :desc).limit(10)
    resource
  end

  def post_params
    params.fetch(:post, {}).permit(:comment)
  end

  def find_post
    @post = current_user.posts.find(params[:id])
  end
end
