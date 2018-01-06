class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  extend Enumerize
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :update_access_token!
  mount_uploader :user_image, UserImageUploader

  has_many :posts

  validates :email, presence: true
  validates :user_name, presence: true, length: { maximun: 15, minimum: 3}, format: { with: /\A[a-z0-9]+\z/i}, uniqueness: true

  enumerize :gender, in: [:male, :female]

  def update_access_token!
    self.access_token = "#{self.id}:#{Devise.friendly_token}"
    save
  end
end
