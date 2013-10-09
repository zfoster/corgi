# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :venue do
    name "MyString"
    description "MyText"
    capacity 1
    street_address_1 "MyString"
    street_address_2 "MyString"
    city "MyString"
    state "MyString"
    zip "MyString"
    uri "MyString"
    contact_name "MyString"
    contact_email "MyString"
    contact_phone "MyString"
  end
end
