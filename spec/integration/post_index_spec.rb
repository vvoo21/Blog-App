require 'rails_helper'

RSpec.describe 'Post Index page', type: :feature do  
    before(:example) do
        @user = User.create(name: 'Vanessa', photo: 'https://unsplash.com/es/fotos/BXCZi9smw78', bio: 'A passionate full-stack developer', posts_counter: 1)
        @post = Post.create(title: 'Hello rails', text: 'My first post', comments_counter: 1, likes_counter: 1, author: @user)
        @comment = Comment.create(text: 'Great post', author: @user, post: @post)
        Like.create(author: @user, post: @post)
        visit user_posts_path(user_id: @user.id)
      end

      it "shows user's profile picture" do
        expect(page).to have_css('img[src*="https://unsplash.com/es/fotos/BXCZi9smw78"]')
      end
  
      it 'shows the users username' do
        expect(page).to have_content('Vanessa')
      end
  
      it 'shows number of posts by user' do
        expect(page).to have_content("Number of posts: #{@user.posts_counter}")
      end
  
      it 'shows posts title' do
        expect(page).to have_content("Post ##{@post.id} #{@post.title}")
      end
  
      it 'shows some of the posts body' do
        expect(page).to have_content 'My first post'
      end
  
      it 'shows the first comment on a post' do
        expect(page).to have_content 'Great post'
      end
  
      it 'shows how many comments a post has.' do
        expect(page).to have_content("Comments: #{@post.comments_counter}")
      end
  
      it 'shows how many likes a post has.' do
        expect(page).to have_content(@post.likes_counter)
      end
  
      it 'should render the pagination button' do
        expect(page).to have_content('Pagination')
      end
  
      it 'When I click on a post, it redirects me to that posts show page' do
        click_link @post.text
        expect(page).to have_current_path(user_post_path(user_id: @user.id, id: @post.id))
      end
end
