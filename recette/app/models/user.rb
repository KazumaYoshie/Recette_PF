class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :post, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  has_many :relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  has_many :reverse_of_relationships, class_name: "Relationship",foreign_key: "followed_id", dependent: :destroy
  has_many :followings, through: :relationships, source: :followd
  has_many :followers, through: :reverse_of_relationships, source: :follower

  attachment :profile_image

  def active_for_authentication?
    super && (self.is_valid == true)
  end

end
