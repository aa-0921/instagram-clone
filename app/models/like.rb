class Like < ApplicationRecord
  belongs_to :user
  belongs_to :insta_post
  counter_culture :insta_post
  validates :user_id, presence: true
  validates :insta_post_id, presence: true
end
