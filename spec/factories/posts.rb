FactoryGirl.define do
  factory :post do
    title "MyString"
    body "MyText"
    admin_user
  end
end
