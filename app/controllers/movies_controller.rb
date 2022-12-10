class MoviesController < ApplicationController
  include SessionCheck
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def create
    movie = current_user.movies.build(movie_params)
    if movie.save
      render json: movie, status: :created
    else
      render json:{ errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  end


  private

  def movie_params
    params.fetch(:movie, {}).permit(:url, :duration, :title, :comment, :thumbnail)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end

  def set_movies
    @movies = current_user.movies.order(created_at: :desc).limit(10).offset(params[:page].to_i * 10)
  end

  def movies
    resource = current_user.id
    resource = current_user.friends.ids if params[:friend] == "true"
    resource = Movie.where(user_id: resource).order(created_at: :desc).limit(10).offset(params[:page].to_i * 10)
    resource
  end

  def movies_total
    total = if params[:friend] == "false"
              total ||= current_user.movies.count
            else
              total ||= Movie.where(user_id: current_user.friends.ids).count
            end
  end

  def login_user

  end
end
