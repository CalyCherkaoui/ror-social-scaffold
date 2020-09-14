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
end
