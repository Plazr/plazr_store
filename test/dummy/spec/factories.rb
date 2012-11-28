FactoryGirl.define do

  factory :discount_type, :class => PZS::DiscountType do 
    sequence(:name) { |n| "Discount #{n}" }
    description "Description"

    factory :black_friday_discount do
      name "Black Friday"
    end

    factory :invalid_discount_type do
      name nil
    end
  end

  factory :brand, :class => PlazrStore::Brand do
    sequence(:name) { |n| "Name #{n}" }

    factory :adidas_brand do
       name "Adidas" 
    end

    factory :invalid_brand do
       name nil 
    end
  end

  factory :prototype, :class => PZS::Prototype do
    sequence(:name) { |n| "Name #{n}" }
  end

  factory :property, :class => PZS::Property do
    sequence(:id_name) { |n| "Id Name #{n}" }
    sequence(:display_name) { |n| "Name #{n}" }
    #prototypes {[FactoryGirl.create(:prototype)]}
  end

  factory :prototype_with_properties, parent: :prototype do
    after(:create) do |prototype|
      prototype.properties = [1, 2, 3].map { |i| FactoryGirl.create(:property) }
    end
  end
end