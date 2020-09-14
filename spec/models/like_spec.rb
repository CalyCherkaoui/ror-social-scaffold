require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'associations' do
    it 'should belong to a user' do
      like = Like.reflect_on_association(:user)
      expect(like.macro).to eq(:belongs_to)
    end
    it 'should belong to a post' do
      like = Like.reflect_on_association(:post)
      expect(like.macro).to eq(:belongs_to)
    end
  end
end
