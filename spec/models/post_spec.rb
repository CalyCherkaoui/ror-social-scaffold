require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'creating valid posts' do
    it 'A post with content and valid user should be valid' do
      user = User.new(name: 'usertest2',
                      email: 'usertest2@test.com',
                      password: 'foobar',
                      password_confirmation: 'foobar')
      user.save

      post = Post.new(user: user, content: 'Foobar')

      expect(post.save).to eq(true)
    end
  end

  context 'associations' do
    it 'should have many comments' do
      post = Post.reflect_on_association(:comments)
      expect(post.macro).to eq(:has_many)
    end
    it 'should many likes' do
      post = Post.reflect_on_association(:likes)
      expect(post.macro).to eq(:has_many)
    end
  end
end
