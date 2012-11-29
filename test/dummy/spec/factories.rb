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

  factory :property, :class => PZS::Property do
    sequence(:id_name) { |n| "Id Name #{n}" }
    sequence(:display_name) { |n| "Name #{n}" }

    factory :silk_property do
      id_name "Silk"
      display_name "Silk"
    end

    factory :invalid_property do
      display_name nil
    end
  end

  factory :variant_property, :class => PZS::VariantProperty do
    sequence(:id_name) { |n| "Id Name #{n}" }
    sequence(:display_name) { |n| "Name #{n}" }

    factory :size_variant_property do
      id_name "Size"
      display_name "Size"
    end

    factory :invalid_variant_property do
      display_name nil
    end

  end
end
