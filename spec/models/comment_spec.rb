require 'rails_helper'

RSpec.describe Comment, type: :model do
  context 'validations' do
    it 'content should be present' do
      user1 = User.new(name: 'usertest', email: 'usertest@test.com', password: 'foobar', password_confirmation: 'foobar')
      user1.save

      user2 = User.new(name: 'usertest2', email: 'usertest@test2.com', password: 'foobar2', password_confirmation: 'foobar2')
      user2.save

      post1 = Post.new(content: 'test post', user: user1)
      post1.save

      comment = Comment.new(content: 'test comment')
      comment.post_id = post1.id
      comment.user = user2

      expect(comment.save).to eq(true)
    end
  end

  context 'associations' do
    it 'should belong to a user' do
      comment = Comment.reflect_on_association(:user)
      expect(comment.macro).to eq(:belongs_to)
    end
    it 'should belong to a post' do
      comment = Comment.reflect_on_association(:post)
      expect(comment.macro).to eq(:belongs_to)
    end
  end
end
