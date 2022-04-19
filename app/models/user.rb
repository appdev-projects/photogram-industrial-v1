# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  comments_count         :integer
#  email                  :citext           default(""), not null
#  encrypted_password     :string           default(""), not null
#  likes_count            :integer
#  photos_count           :integer
#  private                :boolean
#  remember_created_at    :datetime
#  reset_password_sent_at :datetime
#  reset_password_token   :string
#  username               :citext
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#  index_users_on_username              (username) UNIQUE
#
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :own_photos, class_name:"Photo", foreign_key:"owner_id"
 
  has_many :comments, foreign_key:"author_id"

  has_many :received_follow_requests, class_name: "FollowRequest", foreign_key: :recipient_id
  has_many :sent_follow_requests, class_name: "FollowRequest", foreign_key: :sender_id

  has_many :accepted_received_follow_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: :recipient_id
  has_many :accepted_sent_follow_requests, -> { where(status: "accepted") }, class_name: "FollowRequest", foreign_key: :sender_id
  
  has_many :likes, foreign_key: :fan_id
  
  has_many :liked_photos, through: :likes, source: :photo
  
  has_many :follower, through: :accepted_received_follow_requests, source: :recipient
  has_many :leaders, through: :accepted_sent_follow_requests, source: :recipient

  has_many :feed,through: :leaders, source: :own_photos

  has_many :discover, through: :leaders, source: :liked_photos

end
