require 'rails_helper'

RSpec.describe User, type: :model do
  subject { User.new(name: 'vanessa', photo: 'https://pixabay.com/photos/cat-baby-profile-animal-shelter-2671159/', bio: 'A passionate full-stack developer') }

  before { subject.save }

  it 'name should be present' do
    subject.name = nil
    expect(subject).to_not be_valid
  end

  it 'name should not to be too short' do
    subject.name = 'v'
    expect(subject).to_not be_valid
  end

  it 'photo should be present' do
    subject.photo = nil
    expect(subject).to_not be_valid
  end

  it 'photo should have a valid value' do
    expect(subject.photo).to eql 'https://pixabay.com/photos/cat-baby-profile-animal-shelter-2671159/'
  end

  it 'bio should be present' do
    subject.bio = nil
    expect(subject).to_not be_valid
  end

  it 'bio should not to be too short' do
    subject.name = 'developer'
    expect(subject).to_not be_valid
  end

  it 'bio should not to be too long' do
    subject.name = 'A passionate full-stack developer' * 30
    expect(subject).to_not be_valid
  end

  it 'posts_counter should be present' do
    subject.posts_counter = nil
    expect(subject).to_not be_valid
  end

  it 'posts_counter should not to be less than 0' do
    subject.posts_counter = -21
    expect(subject).to_not be_valid
  end

  it 'posts_counter should not to be float' do
    subject.posts_counter = 5.25
    expect(subject).to_not be_valid
  end

  it 'has many posts' do
    post1 = subject.posts.new(title: 'Hello Rails', text: 'This is my first post.')
    post1.save
    post2 = subject.posts.new(title: 'Goodbye Rails', text: 'This is my last post.')
    post2.save

    expect(subject.posts).to eq([post1, post2])
  end

  it 'returns the 3 most recent posts' do
    post1 = subject.posts.new(title: 'Post 1', text: 'Text for post 1')
    post1.save
    post2 = subject.posts.new(title: 'Post 2', text: 'Text for post 2')
    post2.save
    post3 = subject.posts.new(title: 'Post 3', text: 'Text for post 3')
    post3.save
    post4 = subject.posts.new(title: 'Post 4', text: 'Text for post 4')
    post4.save

    expect(subject.recent_posts).to eq([post2, post3, post4])
  end
end
