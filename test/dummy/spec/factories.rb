FactoryGirl.define do
  factory :brand, :class => PlazrStore::Brand do
    sequence(:name) { |n| "Name #{n}" }
  end
end
