class RequestSerializer < ActiveModel::Serializer
  attributes :name, :image_url, :uuid
end
