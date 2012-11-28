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

  factory :brand, :class => PZS::Brand do
    sequence(:name) { |n| "Name #{n}" }

    factory :adidas_brand do
       name "Adidas" 
    end

    factory :invalid_brand do
       name nil 
    end
  end
end
