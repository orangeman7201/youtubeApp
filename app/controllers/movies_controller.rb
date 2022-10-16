class MoviesController < ApplicationController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404
  before_action :set_movies, only: [:index, :total_duration]
  before_action :set_weekly_movies, only: [:weekly_duration_sum]

  def index
    render json: {movies: movies, total: movies_total}
  end

  def show
    @movie ||= Movie.find(params[:id])
    render json: @movie
  end

  def create
    movie = current_user.movies.build(movie_params)
    if movie.save
      render json: movie, status: :created
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

  def weekly_duration_sum
    array = []
    week_array.each do |date|
      hash = {
        date: nil,
        duration: nil,
      }
      duration_sum = @weekly_movies.where(date: date.beginning_of_day .. date.end_of_day).sum(:duration)
      hash[:date] = date
      hash[:duration] = duration_sum
      hash[:duration] = duration_sum
      array.push(hash)
    end
    render json: array.reverse
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

  def set_weekly_movies
    @weekly_movies ||= current_user.movies.target_week(params[:dateStatus].to_i)
  end

  def week_array
    date_array = []
    today = Date.today + params[:dateStatus].to_i.day
    7.times { |x| date_array.push(today - x.day) }
    date_array.reverse
  end
end
