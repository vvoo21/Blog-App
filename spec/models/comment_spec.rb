require 'rails_helper'

RSpec.describe Comment, type: :model do
  let(:user) { User.new(name: 'David', photo: 'photo.png', bio: 'A full-stack developer', posts_counter: 0) }
  let(:post) do
    Post.new(author: user, title: 'Hello rails',
             text: 'Rails is a web application framework running on the Ruby programming language',
             comments_counter: 0,
             likes_counter: 0)
  end

  subject { Comment.new(post:, author: user, text: 'Hi Vanessa!') }

  before { subject.save }

  describe 'validations' do
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_least(2) }
    it { should validate_length_of(:text).is_at_most(100) }
  end

  it 'belongs to an author' do
    expect(subject.author).to eql user
  end

  it 'belongs to a post' do
    expect(subject.post).to eql post
  end

  it 'increments the comments_counter of the post' do
    expect(post.comments_counter).to eq(1)
  end

  it 'decrements the comments_counter of the post' do
    subject.destroy
    expect(post.comments_counter).to eq(0)
  end
end
