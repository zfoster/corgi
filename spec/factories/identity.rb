FactoryGirl.define do
  factory :identity do
    provider 'facebook'
    sequence(:uid) { |n| "#{n}" }
  end
end