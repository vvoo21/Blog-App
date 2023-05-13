class Post < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  has_many :comments, dependent: :destroy, foreign_key: :post_id
  has_many :likes, dependent: :destroy, foreign_key: :post_id
  after_save :update_posts_counter
  after_destroy :decrease_posts_counter

  validates :title, presence: true, length: { in: 2..250 }
  validates :text, presence: true, length: { in: 10..600 }
  validates :comments_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :likes_counter, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # A method which returns the 5 most recent comments for a given post.
  def recent_comments
    comments.last(5)
  end

  # A method that updates the posts counter for a user.
  def update_posts_counter
    author.increment!(:posts_counter)
  end

  def decrease_posts_counter
    author.decrement!(:posts_counter)
  end
end
