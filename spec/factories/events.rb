FactoryGirl.define do
  factory :event do
    title "CityCamp"
    description "A place to discuss civic hacking things"
    start_time { 7.days.from_now }
    end_time { start_time + 1.hour }
    association :creator
  end
end
