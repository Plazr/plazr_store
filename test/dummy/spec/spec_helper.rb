require 'rubygems'
require 'spork'

#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  unless ENV['DRB']
    require 'simplecov'
    puts 'Starting simplecov on ' + SimpleCov.root(File.expand_path '../../../..', __FILE__)
    SimpleCov.start 'rails'
  end

  ENV["RAILS_ENV"] ||= 'test'

  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'rspec/autorun'
  require 'capybara/rspec'
  require 'factory_girl_rails'
  require 'shoulda/matchers'

  Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}

  RSpec.configure do |config|
    config.mock_with :rspec
    # config.mock_with :mocha
    config.use_transactional_fixtures = true
    config.treat_symbols_as_metadata_keys_with_true_values = true
    config.filter_run focus: true # runs only :focus examples
    config.run_all_when_everything_filtered = true # runs everything if none match
    # config.fixture_path = "#{::Rails.root}/spec/fixtures"
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

    config.before(:each) do
      @routes = PZS::Engine.routes
    end
  end

end

Spork.each_run do
  # if ENV['DRB']
  #   require 'simplecov'
  #   puts 'Starting simplecov on ' + SimpleCov.root(File.expand_path '../../../..', __FILE__)
  #   SimpleCov.start 'rails'
  # end
  # This code will be run each time you run your specs.
end
