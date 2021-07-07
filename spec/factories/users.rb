FactoryBot.define do
  factory :user, class: User do
    name { "Example" }
    sequence(:email) { |n| "tester#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :another_user, class: User do
    name { "Another-Example" }
    sequence(:email) { |n| "another-tester#{n}@example.com" }
    password { "another_password" }
    password_confirmation { "another_password" }
  end
end
