namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    # require 'faker'
    require 'factory_girl_rails'
    require 'database_cleaner'

    puts 'Deleting all records from all tables'
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean

    # ActiveRecord::Base.send(:subclasses).each(&:delete_all)
    # ActiveRecord::Base.send(:subclasses).each do |s|
    #   puts s.name
    # end

    puts 'Generating test data. This might take a while...'
      puts 'Generating brands...'
      FactoryGirl.create_list :brand, 10
      puts 'Generating discount_types...'
      FactoryGirl.create_list :discount_type, 5
      puts 'Generating variant_categories...'
      FactoryGirl.create_list :variant_category, 5
      puts 'Generating shipment_conditions...'
      FactoryGirl.create_list :shipment_condition, 5
      # FactoryGirl.create_list :property, 5
      # FactoryGirl.create_list :variant_property, 5
      puts 'Generating prototypes with properties and variant_properties...'
      FactoryGirl.create_list :prototype_with_properties_and_variant_properties, 5
      puts 'Generating products with master variant...'
      FactoryGirl.create_list :product_with_master_variant, 5
  end
end