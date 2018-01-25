class Tag < ApplicationRecord
  has_many :post_tags, dependent: :destroy
  has_many :posts, through: :post_tags

  scope :select_tag_column, -> { select('name, ifnull(post_count, 0) post_count') }
  scope :with_post_tag, -> { joins('left join (select tag_id, count(*) post_count from post_tags group by tag_id) as count on tags.id = count.tag_id') }
  scope :search_like_tag, ->(tag_name) { where('name LIKE _utf8mb4? COLLATE utf8mb4_unicode_ci', "%#{tag_name}%") }
end
