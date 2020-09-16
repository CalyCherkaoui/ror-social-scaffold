class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :name, presence: true, length: { maximum: 20 }

  has_many :posts
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :friendships, dependent: :destroy
  has_many :inverse_friendships, class_name: 'Friendship', foreign_key: 'friend_id', dependent: :destroy

  def friends
    friends_array = friendships.map { |f| f.friend if f.confirmed }
    friends_array.concat(inverse_friendships.map { |f| f.user if f.confirmed })
    friends_array.compact
  end

  # Users who have yet to confirme friend requests
  def pending_friends
    friendships.map { |f| f.friend unless f.confirmed }.compact
  end

  # has_many :pending_friendships, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'user_id'
  # has_many :pending_friends, through: :pending_friendships, source: :friend

  # Users who have requested to be friends
  def friend_requests
    inverse_friendships.map { |f| f.user unless f.confirmed }.compact
  end

  # has_many :friendship_requests, -> { where confirmed: false }, class_name: 'Friendship', foreign_key: 'friend_id'
  # has_many :friend_requests, through: :friendship_requests, source: :friend

  def confirm_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.confirmed = true
    friendship.save
  end

  def reject_friend(user)
    friendship = inverse_friendships.find { |f| f.user == user }
    friendship.destroy
  end

  def friend?(user)
    friends.include?(user)
  end

  def pending_friend?(user)
    pending_friends.include?(user)
  end
end
