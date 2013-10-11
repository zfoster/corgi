FactoryGirl.define do
  factory :user do
    first_name 'Bob'
    last_name 'Loblaw'
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

  factory :creator, class: User do
    first_name 'Mark'
    last_name 'Clear'
    email 'markexample@test.com'

    ignore do
      services [ :facebook ]
    end

    after(:create) do |user, evaluator|
      evaluator.services.each do |service|
        FactoryGirl.create :creator_identity, provider: service, user: user
      end
    end
  end
end