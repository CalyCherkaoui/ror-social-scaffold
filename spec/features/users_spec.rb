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
end
