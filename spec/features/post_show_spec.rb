require 'rails_helper'

RSpec.describe 'Post show page', type: :feature do
  before(:each) do
    @user = User.create(
      name: 'Gabrielle',
      photo: 'https://pixabay.com/photos/lion-roar-africa-animal-wildcat-3012515/',
      bio: 'Web Developer',
      posts_counter: 2
    )

    @post = Post.create(author: @user, title: 'New post', text: 'Hello Rails', comments_counter: 0, likes_counter: 4)

    @comment1 = Comment.create(post: @post, author: @user, text: 'Enjoy it')
    @comment2 = Comment.create(post: @post, author: @user, text: 'I really liked it')
  end

  it 'should show post title' do
    visit user_post_path(@user.id, @post.id)
    expect(page).to have_content('New post')
  end

  it 'should show post author' do
    visit user_post_path(@user.id, @post.id)
    expect(page).to have_content('Gabrielle')
  end

  it 'should show number of comments' do
    visit user_post_path(@user.id, @post.id)
    expect(page).to have_content('2')
  end

  it 'should show number of likes' do
    visit user_post_path(@user.id, @post.id)
    expect(page).to have_content('4')
  end

  it 'should show post body' do
    visit user_post_path(@user.id, @post.id)
    expect(page).to have_content('Hello Rails')
  end

  it 'displays the user name of each commentor' do
    visit user_post_path(@user.id, @post.id)
    expect(page).to have_content('Gabrielle')
    expect(page).to have_content('Gabrielle')
  end

  it 'displays the comment text' do
    visit user_post_path(@user.id, @post.id)
    expect(page).to have_content('Enjoy it')
    expect(page).to have_content('I really liked it')
  end
end
