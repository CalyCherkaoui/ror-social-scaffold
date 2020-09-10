class FriendshipsController < ApplicationController

  def create
    user = User.find(params[:id])
    if user
      @friendship = current_user.friendships.create(friend: user)
      
      redirect_to user_path(user), notice: "Friendship request created"
    end
  end

  def update

  end

  def show

  end

  def delete

  end
end
