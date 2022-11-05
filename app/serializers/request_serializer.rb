class RequestSerializer < ActiveModel::Serializer
  attributes :id, :name, :image_url, :uuid, :created_at
end
