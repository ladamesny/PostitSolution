FactoryGirl.define do
  factory :post do
    # association :user
    url { Faker::Internet.url }
    description { Faker::Lorem.paragraph }
    title { Faker::Lorem.characters(10) }

    after(:build) do |post|
      post.creator = FactoryGirl.build(:user)
    end

    factory :invalid_post do
      title nil
    end
  end
end
