require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation test' do
    it 'ensures that email is present' do
      user = User.new(name: 'usertest', password: 'foobar', password_confirmation: 'foobar').save
      expect(user).to eq(false)
    end

    it 'The user should be valid' do
      user = User.new(name: 'usertest',
                      email: 'usertest@test.com',
                      password: 'foobar',
                      password_confirmation: 'foobar').save
      expect(user).to eq(true)
    end
  end

  context 'associations' do
    it 'should have many posts' do
      user_x = User.reflect_on_association(:posts)
      expect(user_x.macro).to eq(:has_many)
    end

    it 'should have many comments' do
      user_x = User.reflect_on_association(:comments)
      expect(user_x.macro).to eq(:has_many)
    end

    it 'should have many likes' do
      user_x = User.reflect_on_association(:likes)
      expect(user_x.macro).to eq(:has_many)
    end

    it 'should have many friendships' do
      user_x = User.reflect_on_association(:friendships)
      expect(user_x.macro).to eq(:has_many)
    end

    it 'should have many inverse_friendships' do
      user_x = User.reflect_on_association(:inverse_friendships)
      expect(user_x.macro).to eq(:has_many)
    end
  end
end
