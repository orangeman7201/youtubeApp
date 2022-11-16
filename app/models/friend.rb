class Friend < ApplicationRecord
  belongs_to :user ,class_name: "User"
  belongs_to :friend_user ,class_name: "User"

  validates :user_id, uniqueness: { scope: :friend_user }
end
