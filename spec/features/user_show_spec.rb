require 'rails_helper'
RSpec.describe 'User Show Page', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Timothy',
      photo: 'https://unsplash.com/es/fotos/04OtkxJTQR4',
      bio: 'I enjoy coding',
      posts_counter: 4
    )
    @post = Post.create(
      title: 'Database',
      text: 'Relational database',
      comments_counter: 5,
      likes_counter: 13,
      author: @user
    )
    visit user_path(id: @user.id)
  end
  it 'displays a container for the users' do
    expect(page).to have_css('section.user-section')
  end
  it "displays the user's profile picture" do
    expect(page.has_xpath?("//img[@src = 'https://unsplash.com/es/fotos/04OtkxJTQR4' ]"))
  end
  it "displays the user's username" do
    expect(page).to have_content(@user.name)
  end
  it 'shows the number of posts the user has written' do
    expect(page).to have_content(@user.posts_counter)
  end
  it "shows the user's bio" do
    expect(page).to have_content(@user.bio)
  end
  it 'shows the first 3 posts of the user' do
    @user.recent_posts.each do |post|
      expect(page).to have_content(post.id)
      expect(page).to have_content(post.title)
      expect(page).to have_content(post.text)
      expect(page).to have_content(post.comments_counter)
      expect(page).to have_content(post.likes_counter)
    end
  end
  it 'redirects to the post show page on clicking a user post' do
    click_link(@post.text)
    expect(page).to have_current_path(user_post_path(@user, @post))
  end
end
