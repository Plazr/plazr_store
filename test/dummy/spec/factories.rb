FactoryGirl.define do
  factory :brand, :class => PZS::Brand do
    sequence(:name) { |n| "Name #{n}" }

    factory :adidas_brand do
      name "Adidas" 
    end

    factory :invalid_brand do
      name nil 
    end
  end

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

  factory :prototype, :class => PZS::Prototype do
    sequence(:name) { |n| "Name #{n}" }

    factory :clothes_prototype do
      name "Clothes" 
    end

    factory :invalid_prototype do
      name nil 
    end
  end

  factory :property, :class => PZS::Property do
    sequence(:id_name) { |n| "Id Name #{n}" }
    sequence(:display_name) { |n| "Name #{n}" }

    factory :silk_property do
      id_name "Material"
      display_name "Material"
    end

    factory :invalid_property do
      display_name nil
    end
  end
end
