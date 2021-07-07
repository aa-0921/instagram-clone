Faker::Config.locale = :ja

User.create!(name: "Example User",
             email: "example@example.org",
             password:             "example",
             password_confirmation:"example",
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

users = User.order(:created_at).take(50)
count = 1

users.each do |user|
  content = Faker::Lorem.sentence(word_count: 3)
  emoji = Faker::Lorem.multibyte

  user.insta_posts.create!(content: "#{content}#{emoji}",
                           picture: open("db/seeds/images/image-#{count}.jpg"))
  count += 1
end

5.times do 
  50.times do |n|
    user_id = rand(1..50)
    insta_post_id = n + 1
    body = Faker::Lorem.sentence(word_count: 2)
    emoji = Faker::Lorem.multibyte
    Comment.create!(user_id: user_id,
                    insta_post_id: insta_post_id,
                    body: "#{body}#{emoji}",
                    picture: open("db/seeds/images/image-#{rand(1..50)}.jpg"))
  end
end


# リレーションシップ
users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
