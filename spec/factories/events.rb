FactoryGirl.define do
  factory :event do
    title "CityCamp"
    description "A place to discuss civic hacking things"
    start_time { 7.days.from_now }
    end_time { start_time + 1.hour }
    city 'Madison'
    state 'WI'
    zip_code '53703'
    association :creator, factory: :user
    organization

    factory :paid_event do
      title "PaidCityCamp"
      price 5
    end
  end
end
