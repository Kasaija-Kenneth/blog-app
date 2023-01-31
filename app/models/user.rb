class User < ApplicationRecord
  has_many :comments, foreign_key: 'user_id'
  has_many :posts, foreign_key: 'user_id'
  has_many :likes, foreign_key: 'user_id'

  validates :Name, presence: true

  validates :PostsCounter, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end
end
