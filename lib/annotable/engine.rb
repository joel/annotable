module Annotable
  class Engine < ::Rails::Engine
    isolate_namespace Annotable
    config.generators do |g|
      g.test_framework :rspec
    end
    config.generators.api_only = true
  end
end
