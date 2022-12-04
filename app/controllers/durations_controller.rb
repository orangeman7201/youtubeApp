class DurationsController < ApplicationController
  before_action :set_movie, only: [:index]
  before_action :set_weekly_movies, only: [:weekly_duration_sum]

  def index
    render json: { total_duration: @movie.sum(:duration) }
  end
  
  def weekly_duration_sum
    array = []
    week_array.each do |date|
      hash = {
        date: nil,
        duration: nil,
      }
      duration_sum = @weekly_movies.where(created_at: date.beginning_of_day .. date.end_of_day).sum(:duration)
      hash[:date] = date
      hash[:duration] = duration_sum
      hash[:duration] = duration_sum
      array.push(hash)
    end
    render json: array.reverse
  end

  private

  def set_movie
    @movie ||= current_user.movies.today.order(created_at: :desc)
  end

  def set_weekly_movies
    @weekly_movies ||= current_user.movies.this_week
  end

  def week_array
    date_array = []
    today = Date.today + params[:dateStatus].to_i.day
    7.times { |x| date_array.push(today - x.day) }
    date_array.reverse
  end
end
