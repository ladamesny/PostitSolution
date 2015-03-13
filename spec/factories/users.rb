FactoryGirl.define do
  factory :user do
    username 'ladamesny'
    password { Faker::Internet.password(5) }
    role 'moderator'

    factory :admin_user do
      role 'admin'
    end
  end
end
