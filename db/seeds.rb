PlazrAuth::Engine.load_seed

module PlazrStore
  puts 'Creating default Discount Types'

  discount_types = [
    {name:'Flat Percent', description:'The price is updated by a given percentage.', scope:0, type_id:1},
    {name:'Pack Discount', description:'If a given number of products are bought, a discount is applied', scope:1, type_id:2},
    {name:'New Price', description:'A new price is set to the product.', scope:2, type_id:3},
    {name:'Number Items', description:'A discount is applied if a given number of items are bought.', scope:1, type_id:4}
  ]

  discount_types.each do |attributes|
    DiscountType.find_or_initialize_by_name(attributes[:name]).tap do |found_dt|
      found_dt.name = attributes[:name]
      found_dt.description = attributes[:description]
      found_dt.scope = attributes[:scope]
      found_dt.type_id = attributes[:type_id]
      found_dt.save!
    end
  end
end