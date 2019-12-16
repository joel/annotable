module Annotable
  class Engine < ::Rails::Engine
    isolate_namespace Annotable
    config.generators do |g|
      g.fixture_replacement :fabrication
      g.test_framework      :rspec, fixture: true
    end
    config.generators.api_only = true
  end
end
