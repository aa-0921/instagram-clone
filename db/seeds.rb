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










  # content = Faker::Lorem.words

  # InstaPost.create(picture: open("./db/seeds/images/image-#{count}.jpeg"))


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
