# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    registration_id 1
    amount_in_cents 1
    first_name "MyString"
    last_name "MyString"
    card_type "MyString"
    card_expires_on "2013-10-21"
    last_4 "MyString"
  end
end
