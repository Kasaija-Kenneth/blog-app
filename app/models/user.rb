class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :comments, foreign_key: 'author_id', dependent: :destroy
  has_many :posts, foreign_key: 'author_id', dependent: :destroy
  has_many :likes, foreign_key: 'author_id', dependent: :destroy

  validates :name, presence: true
  after_initialize :set_defaults
  validates :posts_counter, numericality: {
    greater_than_or_equal_to: 0,
    only_integer: true
  }

  def recent_posts
    posts.order(created_at: :desc).limit(3)
  end

  def set_defaults
    self.posts_counter ||= 0 if has_attribute? :posts_counter
  end
end
