require 'lorem_ipsum_amet'

module PlazrStore
  class Engine < ::Rails::Engine
    isolate_namespace PlazrStore
  end

  PZS=PlazrStore
end
