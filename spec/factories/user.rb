FactoryGirl.define do
  factory :user do
    name 'Bob Loblaw'
    email 'bob@example.com'

    ignore do
      services [ :facebook ]
    end

    after(:create) do |user, evaluator|
      evaluator.services.each do |service|
        FactoryGirl.create :identity, provider: service , user: user
      end
    end

  end
end