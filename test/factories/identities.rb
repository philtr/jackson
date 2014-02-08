FactoryGirl.define do
  factory :identity do
    provider "factory_girl"
    sequence(:uid) { |n| n.to_s }
  end
end
