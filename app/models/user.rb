class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  has_many :posts, dependent: :destroy, foreign_key: :author_id
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  attribute :posts_counter, :integer, default: 0

  validates :name, presence: true, length: { minimum: 2 }
  validates :photo, presence: true
  validates :bio, presence: true, length: { in: 10..250 }
  validates :posts_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  def recent_posts
    posts.includes(:author).order(created_at: :desc).limit(3)
  end
end
