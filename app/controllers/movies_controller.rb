class MoviesController < ApiController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    movies = Movie.all
    # movies = Movie.select(:id, :title, :duration, :url, :comment) 上のやつこういう書き方もできて.select意向のデータしかフロントに送られない
    render json: movies
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end

  def create
    logger.debug(movie_params)
    movieData = Movie.new(movie_params)
    if movieData.save
      render json: movieData, status: :created
    else
      # ↓あんまり理解できていない。なぜmovie.errorsになるのか？movieはいったいどこから出現したのか？
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
end
