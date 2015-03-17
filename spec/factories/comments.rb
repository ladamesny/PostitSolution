FactoryGirl.define do
  factory :comment do
    body { Faker::Lorem.paragraph(3) }

    after(:build) do |comment|
      comment.creator = FactoryGirl.build(:user)
      comment.post = FactoryGirl.build(:post)
    end

    factory :invalid_comment do
      body nil
    end
  end
end
