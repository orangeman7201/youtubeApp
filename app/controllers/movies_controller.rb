class MoviesController < ApplicationController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404
  before_action :set_movies, only: [:index, :total_duration]

  def index
    if current_user
      render json: @movies
    else
      render json:{ errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def show
    @movie ||= Movie.find(params[:id])
    render json: @movie
  end

  def create
    movieData = Movie.new(movie_params)
    movieData.user_id = current_user.id
    if movieData.save
      current_total_duration = current_user.total_duration + movieData.duration
      current_user.update_attribute(:total_duration, current_total_duration)
      render json: movieData, status: :created
    else
      render json:{ errors: movie.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def update
    movie = Movie.find(params[:id])
    movie.update(comment: params[:comment])
  end

  def destroy
    movie = Movie.find(params[:id])
    movie.destroy
  end

  def total_duration
    render json: { total_duration: @movies.sum(:duration) }
  end

  private

  def movie_params
    params.fetch(:movie, {}).permit(:url, :duration, :title, :comment, :thumbnail, :date)
  end

  def render_status_404(exception)
    render json: { errors: [exception] }, status: 404
  end

  def render_status_500(exception)
    render json: { errors: [exception] }, status: 500
  end

  def set_movies
    if !@movies || @movies&.first&.date&.beginning_of_day != (Date.today + params[:dateStatus].to_i.day).beginning_of_day
      @movies = current_user.movies.target_date(params[:dateStatus]).order(created_at: :desc)
    end
  end
end
