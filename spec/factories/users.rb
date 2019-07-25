FactoryGirl.define do
  factory :user do
    name 'test123'
    email 'test@example.com'
    password 'password'
    trait :user do
      role 'user'
    end
    trait :admin do
      role 'admin'
    end
  end
end
