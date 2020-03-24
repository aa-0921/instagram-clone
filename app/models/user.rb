require 'bcrypt'

class User < ApplicationRecord
  scope :search_by_keyword, -> (keyword) {
    where("users.name LIKE :keyword", keyword: "%#{sanitize_sql_like(keyword)}%") if keyword.present?
  }
  has_many :insta_posts, dependent: :destroy
  has_many :active_relationships, class_name: "Relationship",
                                  foreign_key: "follower_id",
                                  dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
                                   foreign_key: "followed_id",
                                   dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  attr_accessor :remember_token
  before_save { self.email = email.downcase }
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true

  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
  end

  def User.new_token
    SecureRandom.urlsafe_base64
  end

  # 永続セッションのためにユーザーをデータベースに記憶する
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  # 渡されたパーシャルトークンがダイジェストと一致したらtrueを返す
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    # リメンバーダイジェストを空に
    update_attribute(:remember_digest, nil)
  end

  def feed
    following_ids = "SELECT followed_id FROM relationships WHERE follower_id = :user_id"
    InstaPost.where("user_id IN (#{following_ids}) OR user_id = :user_id", user_id: id)
  end

  # 他のユーザーをフォローの括りに入れる。
  def follow(other_user)
    following << other_user
  end

  # フォローしているユーザーの中から指定のユーザーを検索し、フォロー関係を削除
  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  # 指定のユーザーがフォローしているユーザーであればtrueを返す
  def following?(other_user)
    following.include?(other_user)
  end
end
