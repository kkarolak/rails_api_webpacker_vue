FactoryGirl.define do
  factory :comment do
    content 'test'
    article_id 1
    user_id 1
  end
end
