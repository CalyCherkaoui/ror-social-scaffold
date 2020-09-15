require 'rails_helper'

RSpec.feature "Friendships", type: :feature do
  before :each do
    user1 = User.new(name: 'usertest',
               email: 'usertest@test.com',
               password: 'foobar',
               password_confirmation: 'foobar')
    user1.save
    friend1= User.new(name: 'friendtest',
               email: 'friendtest@test.com',
               password: 'foobar',
               password_confirmation: 'foobar')
    friend1.save
    friendship1 = Friendship.new(user: user1, friend: friend1)
    friendship1.save
    visit new_user_session_path
    within('form') do
      fill_in 'Email', with: 'friendtest@test.com'
      fill_in 'Password', with: 'foobar'
    end
    click_button 'Log in'
    visit friendships_path
  end

  scenario 'Friend accepting friendship request' do
    click_link 'Accept Friend'
    visit users_path
    expect(page).to have_content('you are friends')
  end

  scenario 'Friend rejecting friendship request' do
    click_link 'Reject Friend'
    visit friendships_path
    expect(page).not_to have_content('Name: Usertest')
  end
end
