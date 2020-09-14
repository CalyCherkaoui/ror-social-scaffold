require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'creating valid posts' do
    it 'A post with contentent and valid user should be valid' do
      user = User.new(name: 'usertest2',email:'usertest2@test.com', password: 'foobar', password_confirmation: 'foobar').save
      post = Post.new(user_id: user, content: 'Foobar').save
      # post = user.posts.Create!(content: 'Foobar')
      expect(post).to eq(true)
    end
  end
end
