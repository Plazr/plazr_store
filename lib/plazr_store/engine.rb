module PlazrStore
  class Engine < ::Rails::Engine
    isolate_namespace PlazrStore
    config.generators.integration_tool :rspec
    config.generators.test_framework :rspec
  end

  PZS=PlazrStore
end
