class FriendSerializer < ActiveModel::Serializer
  attributes :name, :limit, :image_url, :duration

  def image_url
    object.image_url
  end

  def duration
    object.movies.where(date: Date.today.beginning_of_day .. Date.today.end_of_day).sum(:duration)
  end
end
