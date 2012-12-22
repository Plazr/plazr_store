$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "plazr_store/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "plazr_store"
  s.version     = PlazrStore::VERSION
  s.authors     = ["Bruno Azevedo", "Miguel Palhas"]
  s.email       = ["azevedo.252@gmail.com"]
  s.homepage    = "http://www.plazr.net"
  s.summary     = "Summary of PlazrStore."
  s.description = "Description of PlazrStore."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.2.9"
  s.add_dependency 'sass-rails'
  s.add_dependency 'compass-rails'
  s.add_dependency 'lorem_ipsum_amet'
  # s.add_dependency "jquery-rails"
  s.add_dependency "rb-readline"
  s.add_dependency "paranoia"
  s.add_dependency "paranoia_uniqueness_validator"
  s.add_dependency "haml"
  s.add_dependency 'paperclip'
  s.add_dependency 'cocaine', '0.3.2'
  s.add_dependency 'turbolinks'

  s.add_development_dependency 'debugger'
  s.add_development_dependency "sqlite3"
  s.add_development_dependency "puma"
  s.add_development_dependency "cucumber-rails"
  s.add_development_dependency "rspec-rails"
  s.add_development_dependency "database_cleaner"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "guard-spork"
  # s.add_development_dependency "mocha"
  s.add_development_dependency "factory_girl_rails"
  s.add_development_dependency "shoulda-matchers"
  s.add_development_dependency "fuubar"
  s.add_development_dependency 'simplecov'
  s.add_development_dependency 'thin'
  s.add_development_dependency 'faker'

  # Mac specific gems
  if RUBY_PLATFORM =~ /darwin/i
    s.add_development_dependency "rb-fsevent"
    s.add_development_dependency "growl"
  end

  # Linux specific gems
  if RUBY_PLATFORM =~ /linux/i
    s.add_development_dependency "rb-inotify"
    s.add_development_dependency "libnotify"
  end
end
