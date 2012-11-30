FactoryGirl.define do
  factory :brand, :class => PZS::Brand do
    sequence(:name) { |n| "Brand #{n}" }

    factory :adidas_brand do
      name "Adidas" 
    end

    factory :invalid_brand do
      name nil 
    end
  end

  factory :discount_type, :class => PZS::DiscountType do 
    sequence(:name) { |n| "Discount #{n}" }
    description "Discount Description"

    factory :black_friday_discount do
      name "Black Friday"
    end

    factory :invalid_discount_type do
      name nil
    end
  end

  factory :prototype, :class => PZS::Prototype do
    sequence(:name) { |n| "Prototype #{n}" }

    factory :clothes_prototype do
      name "Clothes" 
    end

    factory :invalid_prototype do
      name nil 
    end
  end

  factory :prototype_with_properties_and_variant_properties, parent: :prototype do
    after(:create) do |prot| 
      prot.properties << FactoryGirl.create(:property)
      prot.variant_properties << FactoryGirl.create(:variant_property)
    end
  end

  factory :property, :class => PZS::Property do
    sequence(:id_name) { |n| "Property #{n}" }
    sequence(:display_name) { |n| "Property #{n}" }

    factory :silk_property do
      id_name "Material"
      display_name "Material"
    end

    factory :invalid_property do
      display_name nil
    end
  end

  factory :variant_property, :class => PZS::VariantProperty do
    sequence(:id_name) { |n| "Variant Property #{n}" }
    sequence(:display_name) { |n| "Variant Property #{n}" }

    factory :size_variant_property do
      id_name "Size"
      display_name "Size"
    end

    factory :invalid_variant_property do
      display_name nil
    end
  end

end
