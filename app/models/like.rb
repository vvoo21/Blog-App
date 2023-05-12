class Like < ApplicationRecord
  belongs_to :author, class_name: 'User', foreign_key: :author_id
  belongs_to :post
  after_create :update_likes_counter

  # A method that updates the likes counter for a post.
  def update_likes_counter
    post.increment!(:likes_counter)
  end
end
