require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:user) { User.create(name: 'David', photo: 'photo.png', bio: 'A full-stack developer') }
  let(:subject) do
    Post.create(author: user, title: 'Hello rails',
                text: 'Rails is a web application framework running on the Ruby programming language')
  end

  before { user.save }

  it 'belongs to an author' do
    expect(subject.author).to eql user
  end

  it 'title should be present' do
    subject.title = nil
    expect(subject).to_not be_valid
  end

  it 'title should not to be too short' do
    subject.title = 'H'
    expect(subject).to_not be_valid
  end

  it 'title should not to be too long' do
    subject.title = 'Hello rails' * 30
    expect(subject).to_not be_valid
  end

  it 'text should be present' do
    subject.text = nil
    expect(subject).to_not be_valid
  end

  it 'text should not to be too short' do
    subject.text = 'Rails'
    expect(subject).to_not be_valid
  end

  it 'text should not to be too long' do
    subject.text = 'Rails is a web application framework running on the Ruby programming language' * 30
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be present' do
    subject.comments_counter = nil
    expect(subject).to_not be_valid
  end

  it 'comments_counter should not to be less than 0' do
    subject.comments_counter = -21
    expect(subject).to_not be_valid
  end

  it 'comments_counter should be an integer' do
    subject.comments_counter = 5.5
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be present' do
    subject.likes_counter = nil
    expect(subject).to_not be_valid
  end

  it 'likes_counter should not to be less than 0' do
    subject.likes_counter = -21
    expect(subject).to_not be_valid
  end

  it 'likes_counter should be an integer' do
    subject.likes_counter = 5.5
    expect(subject).to_not be_valid
  end

  it 'should return 5 recent comments' do
    expect(subject.recent_comments).to eq(subject.comments.last(5))
  end
end
