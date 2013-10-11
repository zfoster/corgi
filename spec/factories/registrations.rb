FactoryGirl.define do
  factory :registration do
    association :event
    association :user
  end
end
