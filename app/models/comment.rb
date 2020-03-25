class Comment < ApplicationRecord
  mount_uploader :picture, PictureUploader
  belongs_to :user
  belongs_to :insta_post
  validates :body, presence: true, length: { maximum: 140 }
  validates :user_id, presence: true
end
