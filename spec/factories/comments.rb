# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :comment do
    email
    website "http://www.example.com"
    name "Bob"
    ip "123.123.421.123"
    body "My Comment"
    post
  end
end
