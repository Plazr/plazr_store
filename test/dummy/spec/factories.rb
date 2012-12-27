FactoryGirl.define do
  factory :brand, :class => PZS::Brand do
    sequence(:name) { |n| "Brand #{n}" }

    factory :brand_v2 do
      name "Adidas" 
    end

    factory :invalid_brand do
      name nil 
    end
  end

  factory :discount_type, :class => PZS::DiscountType do 
    sequence(:name) { |n| "Discount #{n}" }
    description "Discount Description"

    factory :discount_type_v2 do
      name "Black Friday"
    end

    factory :invalid_discount_type do
      name nil
    end
  end

  factory :product, :class => PZS::Product do
    sequence(:name) { |n| "Product#{n}" }
    details "Details"
    sequence(:slug) { |n| "product-#{n}" }

    factory :product_full do
      ignore do
        variants_count 5
      end

      after(:build) do |p| 
        p.variants << FactoryGirl.create(:variant, product: p)
      end
      after(:create) do |p, evaluator| 
        p.product_properties << FactoryGirl.create(:product_property, :product_id => p.id)
        p.variant_properties << FactoryGirl.create(:variant_property_with_values)
        p.variants << FactoryGirl.create_list(:variant, evaluator.variants_count, product: p)
        p.variants.each do |v|
          p.variant_properties.each do |pvp|
            v.variant_property_values << pvp.variant_property_values.first
          end
        end
      end
    end

    factory :product_v2 do
      name "Pro Evolution Soccer 2012" 
      details "A video game which is the eleventh edition in the Pro Evolution Soccer series developed and published by Konami with production assistance from the Blue Sky Team"
      slug "pes-2012"
    end

    factory :product_with_master_variant do
      after(:build) do |p| 
        p.variants << FactoryGirl.create(:variant, product: p)
      end
      after(:create) do |p| 
        p.product_properties << FactoryGirl.create(:product_property, :product_id => p.id)
        p.variant_properties << FactoryGirl.create(:variant_property_with_values)
      end
    end

    factory :invalid_product do
      name nil 
    end

    factory :product_with_properties_and_variant_properties do
      after(:create) do |p| 
        p.product_properties << FactoryGirl.create(:product_property, :product_id => p.id)
        p.variant_properties << FactoryGirl.create(:variant_property)
      end
    end
  end

  factory :product_property, :class => PZS::ProductProperty do
    association :product
    association :property
    value "prop_value"
  end

  factory :property, :class => PZS::Property do
    sequence(:id_name) { |n| "Property #{n}" }
    sequence(:display_name) { |n| "Property #{n}" }

    factory :property_v2 do
      id_name "Material"
      display_name "Material"
    end

    factory :invalid_property do
      id_name nil
    end
  end

  factory :prototype, :class => PZS::Prototype do
    sequence(:name) { |n| "Prototype #{n}" }

    factory :prototype_v2 do
      name "Clothes" 
    end

    factory :invalid_prototype do
      name nil 
    end

    factory :prototype_with_properties_and_variant_properties do
      after(:create) do |prot| 
        prot.properties << FactoryGirl.create(:property)
        prot.variant_properties << FactoryGirl.create(:variant_property)
      end
    end
  end

  factory :shipment_condition, :class => PZS::ShipmentCondition do
    sequence(:service_name) { |n| "Shipment Service Name #{n}"}
    price {rand(20.0)}
    sequence(:service_details) {|n| "Shipment Service Details #{n}"}

    factory :shipment_condition_v2 do
      service_name "UPS"
      price {63.63}
      service_details "Delivery Time : 20 days"
    end

    factory :invalid_shipment_condition do
      service_name nil
      price -1
      service_details nil
    end
  end

  factory :variant_category, :class => PZS::VariantCategory do
    sequence(:name) { |n| "Name #{n}" }
    description "Description"
    is_leaf false
    parent_variant_category_id ""

    factory :variant_category_not_leaf do
    end

    factory :variant_category_v2 do
      name "Sapatilhas"
    end

    factory :invalid_variant_category do
      name nil
    end
  end

  factory :variant, :class => PZS::Variant do
    sequence(:sku) {|n| "SKU#{n}"}
    description "Description"
    price {rand(50.0)}
    visible true
    amount_available {rand(20)}
    is_master true
    association :product

    factory :variant_v2 do
      sequence(:sku) {|n| "SKU_v2"}
      association :product
    end

    factory :invalid_variant do
      sku nil 
      price nil
      visible nil
      amount_available nil
      is_master nil
      # product nil
    end
  end

  factory :variant_property, :class => PZS::VariantProperty do
    sequence(:id_name) { |n| "Variant Property #{n}" }
    sequence(:display_name) { |n| "Variant Property #{n}" }

    factory :variant_property_v2 do
      id_name "Size"
      display_name "Size"
    end

    factory :invalid_variant_property do
      id_name nil
    end

    factory :variant_property_with_values do
      after(:create) do |vp| 
        vp.variant_property_values << FactoryGirl.create_list(:variant_property_value, 3, variant_property: vp)
      end
    end
  end

  factory :variant_property_value, :class => PZS::VariantPropertyValue do
    sequence(:name) { |n| "Value #{n}" }
    sequence(:presentation) { |n| "Presentation #{n}" }
  end

  factory :page, :class => PZS::Page do
    sequence(:title) { |n| "Page #{n}" }
    sequence(:slug) { |n| "Page #{n}" }
    sequence(:content) { |n| "Page #{n}" }

    factory :page_v2 do
      title "title_1"
      slug "slug_1"
      content "content_1"
    end

    factory :invalid_page do
      title nil
    end
  end
end
