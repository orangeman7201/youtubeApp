class MoviesController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    movies = Movie.all
    # movies = Movie.select(:id, :title, :duration, :url, :comment) 上のやつこういう書き方もできて.select意向のデータしかフロントに送られない
    render json: movies
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end
end
