class MoviesController < ApiController
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render json: { error: '404 not found' }, status: 404
  end

  def index
    movies = Movie.all
    render json: movies
  end

  def show
    render json: @movie
  end

  private

    def set_movie
      @movie = Movie.find(params[:id])
    end
end
