FactoryGirl.define do

  factory :user, :class => PlazrAuth::User do

    factory :specific_user do
      first_name 'FirstName'
      last_name  'LastName'
      sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
      sequence(:password) { |n| "bigpassword#{n}" }
      sequence(:password_confirmation) { |n| "bigpassword#{n}" }
      confirmed_at { Time.now }
    end
  end
end
