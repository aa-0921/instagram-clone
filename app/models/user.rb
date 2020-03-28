require 'bcrypt'

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  # # devise :database_authenticatable, :registerable,
  #        :recoverable, :rememberable, :validatable, :omniauthable
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
  validates :name, presence: true, length: { maximum: 50 } # unless: :uid?,
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i.freeze

  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false } # unless: :uid?,
  has_secure_password
  # validations: false
  validates :password, presence: true, length: { minimum: 6 }, allow_nil: true # unless: :uid?,

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

  # auth hashからユーザ情報を取得
  # データベースにユーザが存在するならユーザ取得して情報更新する；存在しないなら新しいユーザを作成する
  # def self.find_or_create_from_auth(auth)
  #   provider = auth[:provider]
  #   uid = auth[:uid]
  #   name = auth[:info][:name]
  #   image = auth[:info][:image]
  #   # 必要に応じて情報追加してください

  #   # ユーザはSNSで登録情報を変更するかもしれので、毎回データベースの情報も更新する
  #   find_or_create_by(provider: provider, uid: uid) do |user|
  #     user.username = name
  #     user.image_path = image
  #   end
  # end

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20] # ランダムなパスワードを作成
      user.image = auth.info.image.gsub("_normal", "") if user.provider == "twitter"
      user.image = auth.info.image.gsub("picture", "picture?type=large") if user.provider == "facebook"
    end
  end

  def self.find_for_oauth(auth)
    user = User.where(uid: auth.uid, provider: auth.provider).first

    user ||= User.create(
      uid: auth.uid,
      provider: auth.provider,
      email: auth.info.email,
      password: Devise.friendly_token[0, 20]
    )

    user
  end
end
