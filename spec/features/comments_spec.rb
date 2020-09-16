require 'rails_helper'

RSpec.describe 'Comments', type: :feature do
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

    post_x = Post.new(user: user1, content: 'Foobar')
    post_x.save
    comment_x = Comment.new(user: user1, content: 'my own comment', post: post_x)
    comment_x.save

    visit new_user_session_path

    within('form') do
      fill_in 'Email', with: 'userit@it.com'
      fill_in 'Password', with: 'foobar'
    end
    click_button 'Log in'
    visit friendships_path
  end

  it 'visiting the index' do
    visit posts_url
    assert_text 'my own comment'
  end

  it 'creating a Comment' do
    visit posts_url
    within('form.new_comment') do
      fill_in 'Content', with: 'my own comment 2'
    end
    click_on 'Comment'

    assert_text 'Comment was successfully created.'
  end
end
