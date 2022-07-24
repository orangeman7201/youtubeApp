class PostSerializer < ActiveModel::Serializer
  attributes :id, :comment, :duration, :created_at
  belongs_to :user, serializer: UserSerializer do
    object.user
  end

  def duration
  end
end
