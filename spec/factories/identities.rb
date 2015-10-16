FactoryGirl.define do
  factory :identity do
    provider { "factory_girl_#{ uid }" }
    sequence(:uid) { |n| n.to_s }
  end
end
