class MoviesController < ApiController
  rescue_from Exception, with: :render_status_500
  rescue_from ActiveRecord::RecordNotFound, with: :render_status_404

  def index
    if user_id = session[:user_id]
      user = User.find_by(id: user_id)
      movies = user.movies
      render json: movies
    elsif user_id = cookies.signed[:user_id]
      user = User.find_by(id: user_id)
      if user && user.authenticate(remember_digest: User.digest(cookies[:remember_token]))
        log_in(user)
        movies = user.movies
        render json: movies
      else
        render json:{ errors: movie.errors.full_messages }, status: :unprocessable_entity
      end
    end
  end

  def show
    @movie = Movie.find(params[:id])
    render json: @movie
  end

  def create
    debugger
    movieData = Movie.new(movie_params)
    movieData.user_id = session[:user_id]
    user = User.find(session[:user_id])
    user.total_duration += movieData.duration
    if movieData.save
      user.save
      render json: movieData, status: :created
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
end
