class Post < ApplicationRecord
  validates :content, presence: true, length: { maximum: 1000,
                                                too_long: '1000 characters in post is the maximum allowed.' }

  belongs_to :user

  scope :ordered_by_most_recent, -> { order(created_at: :desc) }
  scope :desc_current_user_and_friends, lambda { |current_user|
                                          where(user: current_user.friends << current_user)
                                            .order(created_at: :desc)
                                        }
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
end
