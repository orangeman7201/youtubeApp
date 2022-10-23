class UserSerializer < ActiveModel::Serializer
  attributes :id, :name, :limit, :image_url, :uuid

  def image_url
    object.image_url
  end
end
