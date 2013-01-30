require 'jquery-rails'
require 'haml'
require 'compass-rails'
require 'sass-rails'
require 'paranoia'
require 'paranoia_uniqueness_validator'
require 'paperclip'
require 'turbolinks'
require 'better_errors'
require 'redactor-rails'
require 'carrierwave'
require 'mini_magick'
require 'activemerchant'
require 'will_paginate'
require 'will_paginate-bootstrap'

module PlazrStore
  class Engine < ::Rails::Engine
    isolate_namespace PlazrStore
    config.generators do |g|
      # g.javascripts :false
      # g.helper :false
      g.template_engine :haml
      g.integration_tool :rspec
      g.test_framework :rspec
    end

    config.to_prepare do
      Dir.glob(PlazrStore::Engine.root + "app/decorators/**/*_decorator*.rb").each { |c| require_dependency(c) }
    end
  end

  PZS=PlazrStore
end
