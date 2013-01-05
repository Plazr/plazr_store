FactoryGirl.define do

  factory :user, :class => PlazrAuth::User do

    factory :specific_user do
      first_name 'FirstName'
      last_name  'LastName'
      sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
      sequence(:password) { |n| "bigpassword#{n}" }
      sequence(:password_confirmation) { |n| "bigpassword#{n}" }
      confirmed_at { Time.now }

      factory :admin do
        #after(:create) { |u| u.roles << PlazrAuth::Role.find_by_name('admin') }
        after(:create) { |u| u.roles << FactoryGirl.create(:admin_role) }
      end

      factory :root do
        after(:create) { |u| u.roles << FactoryGirl.create(:root_role) }
      end

      factory :staff do
        after(:create) { |u| u.roles << FactoryGirl.create(:staff_role) }
      end

      factory :user_with_user_role do
        after(:create) { |u| u.roles << FactoryGirl.create(:user_role) }
      end
    end
  end

  factory :role, :class => PlazrAuth::Role do
    name 'dummy_role'

    factory :admin_role do
      name 'admin'
    end

    factory :root_role do
      name 'root'
    end

    factory :staff_role do
      name 'staff'
    end

    factory :user_role do
      name 'user'
    end
  end
  
end
