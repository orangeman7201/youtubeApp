class Post < ApplicationRecord
  has_many :replies, dependent: :destroy
  
  belongs_to :user, foreign_key: 'user_id'
end
