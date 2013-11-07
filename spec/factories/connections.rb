# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :connection do
    follow "MyString"
    user_id nil
    followed_user_id nil
    source "MyString"
    source_id "MyString"
  end
end
