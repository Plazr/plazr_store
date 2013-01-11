FactoryGirl.define do
  factory :address, :class => PZS::Address do
    sequence(:address1) { |n| "Address1_#{n}" }
    sequence(:city) { |n| "City#{n}" }
    sequence(:first_name) { |n| "FirstName#{n}" }
    sequence(:last_name) { |n| "LastName#{n}" }
    sequence(:phone) { |n| "Phone_#{n}" }
    sequence(:zipcode) { |n| "Zipcode_#{n}" }
  end

  factory :brand, :class => PZS::Brand do
    sequence(:name) { |n| "Brand #{n}" }

    factory :brand_v2 do
      name "Adidas" 
    end

    factory :invalid_brand do
      name nil 
    end
  end

  factory :cart, :class => PZS::Cart do
    after(:build) do |c| 
      c.user_id = FactoryGirl.create(:specific_user).id
    end
    after(:create) do |c|
      p = FactoryGirl.create(:product_full)
      FactoryGirl.create :cart_variant, cart_id: c.id, variant_id: p.variants.first.id
    end
  end

  factory :cart_variant, :class => PZS::CartVariant do
    association :cart
    association :variant
    amount 1
    state "pending"
  end

  factory :discount_type, :class => PZS::DiscountType do 
    sequence(:name) { |n| "Discount #{n}" }
    description "Discount Description"
    scope {0}

    factory :discount_type_v2 do
      name "Black Friday"
      scope {2}
    end

    factory :invalid_discount_type do
      name nil
    end
  end

  factory :multimedium, :class => PZS::Multimedium do
    sequence(:caption) { |n| "Caption #{n}" }
    file Rack::Test::UploadedFile.new(File.dirname(__FILE__) + "/sample_photo.jpeg", 'image/jpeg')

    factory :multimedium_v2 do
      caption "Good Multimedium"
      association :variant
    end

    factory :multimedium_for_variant do
      association :variant
    end

    factory :multimedium_for_page do
      association :page
    end

    factory :invalid_multimedium do
      file nil
    end
  end

  factory :order, :class => PZS::Order do 
    # sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
    total 0
    item_total 0
    adjustment_total 0
    payment_state "processing"
    shipment_state "processing"
    state "processing"

    # association :cart
    association :shipment_condition
    # promotional_code

    # after(:build) do |o| 
    #   o.user_id = FactoryGirl.create(:specific_user).id
    # end

    factory :order_with_addresses do
      after(:build) do |o| 
        a = FactoryGirl.create(:address)
        o.billing_address_id = a.id
        o.shipping_address_id = a.id
      end

      factory :order_paypal do
        express_token ""
        payer_id ""
        # shipment_condition_id session[:shipment_condition]
        total 50
      end

      factory :order_full do
        sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
        after(:build) do |o| 
          o.user_id = FactoryGirl.create(:specific_user).id
        end
        association :cart
      end
    end
  end

  factory :order_without_user, :class => PZS::Order do
    sequence(:email) { |n| "someweirdunrepeatableemail#{n}@yourcousin.com" }
    total 0
    item_total 0
    adjustment_total 0
    payment_state "processing"
    shipment_state "processing"
    state "processing"

    association :shipment_condition
    association :cart

    after(:build) do |o| 
      a = FactoryGirl.create(:address)
      o.billing_address_id = a.id
      o.shipping_address_id = a.id
    end
  end

  factory :product, :class => PZS::Product do
    sequence(:name) { |n| "Product#{n}" }
    details "Details"
    sequence(:slug) { |n| "product-#{n}" }
    association :brand

    factory :product_full do
      ignore do
        variants_count 2
      end

      after(:build) do |p| 
        p.variants << FactoryGirl.create(:variant, product: p)
      end
      after(:create) do |p, evaluator| 
        p.product_properties << FactoryGirl.create(:product_property, :product_id => p.id)
        p.variant_properties << FactoryGirl.create(:variant_property_with_values)
        p.variants << FactoryGirl.create_list(:variant, evaluator.variants_count, product: p)
        p.variants.each do |v|
          v.multimedia << FactoryGirl.create_list(:multimedium, 2, variant: v)
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
        p.variant_properties << FactoryGirl.create(:variant_property_with_values)
      end
    end
  end

  factory :product_category, :class => PZS::ProductCategory do
    sequence(:name) { |n| "Name #{n}" }
    description "Description"
    is_leaf false
    parent_product_category_id ""

    factory :product_category_leaf do
      is_leaf true
      after(:build) do |vc| 
        vc.parent_product_category_id = FactoryGirl.create(:product_category).id
      end
    end

    factory :product_category_v2 do
      name "Sapatilhas"
    end

    factory :invalid_product_category do
      name nil
    end
  end

  factory :product_product_category, :class => PZS::ProductProductCategory do
    association :product
    association :product_category
  end

  factory :product_property, :class => PZS::ProductProperty do
    value "x"
    association :product
    association :property
  end

  factory :product_variant_property, :class => PZS::ProductVariantProperty do
    association :product
    association :variant_property
  end

  factory :product_promotion, :class => PZS::ProductPromotion do
    association :product_property
    association :promotion
  end

  factory :promotion, :class => PZS::Promotion do
    sequence(:name) { |n| "Name #{n}" }
    sequence(:description) { |n| "Description #{n}" }
    starts_at "01-01-2013"
    expires_at "31-02-2013"
    value 25
    association :discount_type
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

  factory :variant, :class => PZS::Variant do
    sequence(:sku) {|n| "SKU#{n}"}
    description "Description"
    price {50.0}
    visible true
    amount_available {rand(20)}
    is_master true
    association :product

    factory :variant_not_master do
      is_master false
    end

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

    factory :variant_with_variant_property_values do
      is_master false
      after(:create) do |v|
        v.variant_variant_property_values << FactoryGirl.create(:variant_variant_property_value, :variant_id => v.id)
      end
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
    association :variant_property

    factory :variant_property_value_v2 do
      name "Small"
      presentation "S"
    end

    factory :invalid_variant_property_value do
      name nil
    end
  end

  factory :variant_variant_property_value, :class => PZS::VariantVariantPropertyValue do
    association :variant
    association :variant_property_value
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
