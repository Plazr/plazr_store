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
      FactoryGirl.create_list :brand, 10
      FactoryGirl.create_list :discount_type, 5
      # FactoryGirl.create_list :property, 5
      # FactoryGirl.create_list :variant_property, 5
      FactoryGirl.create_list :prototype_with_properties_and_variant_properties, 5
  end
end
