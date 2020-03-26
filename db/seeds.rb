Faker::Config.locale = :ja

User.create!(name: "Example User",
             email: "example@example.org",
             password:             "foobar",
             password_confirmation:"foobar",
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n+1}@example.org"
  password = "password"
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password)
end


# users = User.order(:created_at).take(6)

# 50.times do |n|
#   content = Faker::Lorem.sentence(8)
#   users.each { |user| user.insta_posts.create!(content: content,
#                                                picture: open("/Users/aa/environment/instagram-clone/db/seeds/images/image-#{n}.jpg")) }
# end





users = User.order(:created_at).take(50)
count = 1

users.each do |user|
  content = Faker::Lorem.sentence(word_count: 3)
  emoji = Faker::Lorem.multibyte

  user.insta_posts.create!(content: "#{content}#{emoji}",
                           picture: open("/Users/aa/environment/instagram-clone/db/seeds/images/image-#{count}.jpg"))
  count += 1
end

3.times do
  50.times do
    user_id = rand(1..50)
    insta_post_id = rand(1..50)
    body = Faker::Lorem.sentence(word_count: 2)
    Comment.create!(user_id: user_id,
                    insta_post_id: insta_post_id,
                    body: body,
                    picture: open("/Users/aa/environment/instagram-clone/db/seeds/images/image-#{rand(1..50)}.jpg"))
  end
end


#  50.times do |n|
#     user_id = n + 1
#     insta_post_id = 50 - n
#     body = Faker::Lorem.sentence(word_count: 2)
#     Comment.create!(user_id: user_id,
#                     insta_post_id: insta_post_id,
#                     body: body,
#                     picture: open("/Users/aa/environment/instagram-clone/db/seeds/images/image-#{n + 1}.jpg"))
#   end


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
