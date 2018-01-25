class Post < ApplicationRecord
  mount_uploader :post_image, PostImageUploader

  belongs_to :user
  belongs_to :category
  has_many :post_tags, dependent: :destroy
  has_many :tags, through: :post_tags
  has_many :likes, dependent: :destroy

  def isLike_user?(user_id)
    likes.find_by(user_id: user_id).present?
  end
end
