class PostSerializer < ActiveModel::Serializer
  attributes :id, :comment, :duration, :created_at
  belongs_to :user, serializer: UserSerializer do
    object.user
  end

  def duration
    object.user.movies.where(date: object.created_at.beginning_of_day..object.created_at.end_of_day).sum(:duration)
  end
end
