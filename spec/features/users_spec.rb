require 'rails_helper'

RSpec.feature 'Users', type: :feature do
  describe 'the sign in process' do
    before :each do
      User.new(name: 'usertest',
               email: 'usertest@test.com',
               password: 'foobar',
               password_confirmation: 'foobar').save
    end

    it 'signs me in should succeed' do
      visit new_user_session_path
      within('form') do
        fill_in 'Email', with: 'usertest@test.com'
        fill_in 'Password', with: 'foobar'
      end
      click_button 'Log in'
      expect(page).to have_content 'Signed in successfully.'
    end

    it 'signs me in should fail' do
      visit new_user_session_path
      within('form') do
        fill_in 'Email', with: 'failed@test.com'
        fill_in 'Password', with: 'foobar'
      end
      click_button 'Log in'
      expect(page).to have_content 'Invalid Email or password'
    end
  end

  scenario 'user seding a friendship request to a friend that will accept it' do

    User.new(name: 'usertest',
               email: 'usertest@test.com',
               password: 'foobar',
               password_confirmation: 'foobar').save
    User.new(name: 'friendtest',
               email: 'friendtest@test.com',
               password: 'foobar',
               password_confirmation: 'foobar').save

      visit new_user_session_path
      within('form') do
          fill_in 'Email', with: 'usertest@test.com'
          fill_in 'Password', with: 'foobar'
      end
      click_button 'Log in'
      visit users_path
      click_link 'Invite to friendship'
      visit friendships_path
      expect(page).to have_content('friendtest')

  end
end
