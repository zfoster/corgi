# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :social_object do
    corgi_foreign_key 1
    corgi_create_date "2013-10-02 12:32:14"
    type ""
    title "MyString"
    description "MyText"
    uri "MyString"
  end
end
