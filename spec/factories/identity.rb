FactoryGirl.define do
  factory :identity do
    provider 'facebook'
    uid '12345'
  end

  factory :creator_identity, class: Identity do
    provider 'facebook'
    uid '12346'
  end
end