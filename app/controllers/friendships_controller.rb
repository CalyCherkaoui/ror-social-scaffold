class FriendshipsController < ApplicationController
  def index
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def create
    user = User.find(params[:id])
    return unless user

    @friendship = current_user.friendships.create(friend: user)
    redirect_to user_path(user), notice: 'Friendship request created'
  end

  def update
    user_to_be_friend = User.find(params[:id])
    friendship = user_to_be_friend.friendships.find_by(friend_id: current_user.id)
    if friendship
      friendship.update(confirmed: true)
      current_user.friends << user_to_be_friend
    end
    redirect_to friendships_path
  end

  def show; end

  def destroy
    user_unfriended = User.find(params[:id])
    friendship_rejected = user_unfriended.friendships.find_by(friend_id: current_user.id)

    if friendship_rejected
      friendship_rejected.destroy
      user_unfriended.friend_requests.delete(current_user)
    end

    # if we are already friend delete from friens array

    redirect_to friendships_path
  end
end
