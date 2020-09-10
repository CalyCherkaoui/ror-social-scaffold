class FriendshipsController < ApplicationController

  def index
    @pending_friends = current_user.pending_friends
    @friend_requests = current_user.friend_requests
  end

  def create
    user = User.find(params[:id])
    if user
      @friendship = current_user.friendships.create(friend: user)
      
      redirect_to user_path(user), notice: "Friendship request created"
    end
  end

  def update
    @friendship = Friendship.find(params[:id])
    @friendship.update(confirmed: true)
    redirect_to friendships_path
  end

  def show

  end

  def destroy
    @friendship = Friendship.find(params[:id])
    @friendship.destroy
    redirect_to friendships_path
  end
end
