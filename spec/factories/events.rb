# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :event do
    name "MyString"
    description "MyText"
    starts_at "2014-01-21 21:41:03"
    ends_at "2014-01-21 21:41:03"
    location "MyString"
    created_by 1
  end
end
