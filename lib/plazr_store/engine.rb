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
  end

  PZS=PlazrStore
end
