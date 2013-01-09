namespace :db do
  desc "Erase and fill database"
  task :populate => :environment do
    # require 'faker'
    require 'factory_girl_rails'
    require 'database_cleaner'

    puts 'Deleting all records from all tables'
      DatabaseCleaner.strategy = :truncation
      DatabaseCleaner.clean
      PlazrAuth::User.with_deleted.all.each { |u| u.destroy! }

    # ActiveRecord::Base.send(:subclasses).each(&:delete_all)
    # ActiveRecord::Base.send(:subclasses).each do |s|
    #   puts s.name
    # end

    puts 'Running db:seed'
    Rake::Task["db:seed"].execute

    puts 'Generating test data. This might take a while...'
      puts 'Generating brands...'
      FactoryGirl.create_list :brand, 10
      puts 'Generating discount_types...'
      FactoryGirl.create_list :discount_type, 5
      puts 'Generating product_categories...'
      FactoryGirl.create_list :product_category, 5
      puts 'Generating shipment_conditions...'
      FactoryGirl.create_list :shipment_condition, 5
      puts 'Generating prototypes with properties and variant_properties...'
      FactoryGirl.create_list :prototype_with_properties_and_variant_properties, 5
      puts 'Generating products with variants...'
      FactoryGirl.create_list :product_full, 5
      puts 'Generating carts with new user'
      FactoryGirl.create_list :cart, 2
      puts 'Generating addresses'
      FactoryGirl.create_list :address, 5
      puts 'Generating admin user'
      FactoryGirl.create :admin, email: "admin@gmail.com", password: "asdasd", password_confirmation: "asdasd"
  end
end
