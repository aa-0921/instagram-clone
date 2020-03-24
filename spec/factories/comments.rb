FactoryBot.define do
  factory :comment do
    user { nil }
    insta_post { "" }
    body { "MyText" }
  end
end
