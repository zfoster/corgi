# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :contributor, :class => 'Contributors' do
    email "MyString"
    contribution "MyString"
  end
end
