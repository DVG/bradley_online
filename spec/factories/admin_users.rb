# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  sequence :email do |n|
    "email#{n}@factory.com"
  end
  sequence :username do |n|
    "user_#{n}"
  end
  factory :admin_user do
    username
    email
    password 'secret'
    password_confirmation { |u| u.password }
  end
end
