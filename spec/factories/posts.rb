FactoryGirl.define do
  factory :post do
    # association :user
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    title { Faker::Lorem.words(4) }

  end
end
