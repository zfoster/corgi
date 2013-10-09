# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    title "MyString"
    description "MyText"
    start_time "2013-10-04 15:01:33"
    end_time "2013-10-04 15:01:33"
    all_day false
    venue_id 1
  end
end
