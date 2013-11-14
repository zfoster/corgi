FactoryGirl.define do
  factory :follow do
    followee_id nil
    follower_id 1
    source 'twitter'
    source_id 'test'
  end
end