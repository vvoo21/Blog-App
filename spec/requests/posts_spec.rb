require 'rails_helper'

RSpec.describe 'Posts', type: :request do
  let!(:user) { User.create(name: 'Anna', photo: 'https://pixabay.com/photos/cat-baby-profile-animal-shelter-2671159/', bio: 'A passionate full-stack developer', posts_counter: 0) }
  describe 'GET /index' do
    it 'response status is success' do
      get user_posts_path(user.id)
      expect(response.status).to eq(200)
    end

    it 'correct template is rendered' do
      get user_posts_path(user.id)
      expect(response).to render_template(:index)
    end

    it 'response body includes correct placeholder text' do
      get user_posts_path(user.id)
      expect(response.body).to include('Username')
    end
  end

  describe 'GET /show' do
    let!(:post) do
      Post.create(author: user, title: 'Hello rails',
                  text: 'Rails is a web application framework running on the Ruby programming language',
                  comments_counter: 0, likes_counter: 0)
    end
    it 'response status is success' do
      get user_post_path(user.id, post.id)
      expect(response.status).to eq(200)
    end

    it 'correct template is rendered' do
      get user_post_path(user.id, post.id)
      expect(response).to render_template(:show)
    end

    it 'response body includes correct placeholder text' do
      get user_post_path(user.id, post.id)
      expect(response.body).to include("Post #1 by user #{user.id}")
    end
  end
end
