class User < ApplicationRecord
  include Rails.application.routes.url_helpers
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :movies, dependent: :destroy
  has_many :active_requests, class_name:"Request", foreign_key: "from_user_id", dependent: :destroy
  has_many :passive_requests, class_name:"Request", foreign_key: "to_user_id", dependent: :destroy
  has_many :requested, through: :passive_requests, source: :from_user
  has_many :request, through: :active_requests, source: :to_user
  has_many :active_friend, class_name: "Friend", foreign_key: "user_id", dependent: :destroy
  has_many :passive_friend, class_name: "Friend", foreign_key: "friend_user_id", dependent: :destroy
  has_many :friends, through: :active_friend, source: :friend_user
  has_many :posts, dependent: :destroy
  has_many :replies, dependent: :destroy
  has_one_attached :image

  attr_accessor :remember_token
  before_save { self.email = self.email.downcase }
  before_validation :set_uuid

  validates :name,  presence: true, length: { maximum: 16 }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }

  validates :password, presence: true, length: { minimum: 6 }, on: :create
  validates :uuid, presence: true, uniqueness: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = User.new_token
    self.update_attribute(:remember_digest, User.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def authenticated?(remember_token)
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def remember_me
    true
  end

  def image_url
    image.attached? ? url_for(image) : nil
  end

  def set_uuid
    if self.uuid.blank?
      uuid = SecureRandom.urlsafe_base64(10)
      while User.exists?(uuid: uuid) do
        uuid = SecureRandom.urlsafe_base64(10)
      end
      self.uuid = uuid
    end
  end
end
