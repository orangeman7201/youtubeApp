class FriendSerializer < ActiveModel::Serializer
  attributes :name, :limit, :image_url

  def image_url
    object.image_url
  end
end
