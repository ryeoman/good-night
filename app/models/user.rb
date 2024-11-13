class User < ApplicationRecord
  # User has many sleeps
  has_many :sleeps

  # User can follow many users through follows
  has_many :follows
  has_many :followed_users, through: :follows, source: :following

  # You may want to define a reverse relationship for "followers"
  has_many :reverse_follows, class_name: "Follow", foreign_key: "following_id"
  has_many :followers, through: :reverse_follows, source: :user
end
