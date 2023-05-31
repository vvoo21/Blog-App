require 'rails_helper'

RSpec.describe 'User Index Page', type: :feature do
  before(:each) do
    @user = User.create(
    name: 'Alex',
    photo: 'https://www.freepik.com/free-photo/closeup-photo-young-lady-looking-down-hedshot-high-quality-photo_26245993.htm#from_view=detail_alsolike',
    bio: 'A modern artist',
    posts_counter: 5
  )
  end

  it 'displays a container for the users' do
    visit users_path
    expect(page).to have_css('section.users-section')
  end

  it 'displays the username of each user' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content(user.name)
    end
  end

  it 'displays the photos of each user' do
    visit users_path
    User.all.each do |user|
      expect(page.has_xpath?("//img[@src = '#{user.photo}' ]"))
    end
  end

  it 'shows the number of posts of each user' do
    visit users_path
    User.all.each do |user|
      expect(page).to have_content("Number of posts: #{user.posts_counter}")
    end
  end

  it "is redirected to that user's show page" do
    visit users_path
    click_link(@user.name)
    expect(page).to have_current_path(user_path(@user.id))
  end
end
