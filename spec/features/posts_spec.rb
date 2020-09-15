require 'rails_helper'

RSpec.describe 'Posts', type: :feature do
  before :each do
    user1 = User.new(name: 'userit',
                     email: 'userit@it.com',
                     password: 'foobar',
                     password_confirmation: 'foobar')
    user1.save
    friend1 = User.new(name: 'friendit',
                       email: 'friendit@it.com',
                       password: 'foobar',
                       password_confirmation: 'foobar')
    friend1.save
    friendship1 = Friendship.new(user: user1, friend: friend1)
    friendship1.save
    visit new_user_session_path
    within('form') do
      fill_in 'Email', with: 'friendit@it.com'
      fill_in 'Password', with: 'foobar'
    end
    click_button 'Log in'
  end

  setup do
    @post = Post.first
  end

  it 'visiting the index' do
    visit posts_url
    assert_selector 'h3', text: 'Recent posts'
  end

  it 'creating a Post' do
    visit posts_url
    within('form.new_post') do
      fill_in 'Content', with: 'any string'
    end
    click_on 'Save'

    assert_text 'Post was successfully created.'
  end
end
