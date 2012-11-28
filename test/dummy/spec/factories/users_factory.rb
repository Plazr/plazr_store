FactoryGirl.define do

  factory :user, :class => PlazrAuth::User do

    factory :specific_user do
      first_name 'FirstName'
      last_name  'LastName'
      email      'someweirdunrepeatableemail69@yourcousing.com'
      password   'bigpassword'
      password_confirmation 'bigpassword'
      confirmed_at { Time.now }
    end
  end
end
