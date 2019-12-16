module Annotable
  class Engine < ::Rails::Engine
    isolate_namespace Annotable
    config.generators do |g|
      g.fixture_replacement :fabrication
      g.test_framework      :rspec, fixture: true
      g.orm :active_record, primary_key_type: :uuid
    end
    config.generators.api_only = true
    config.generators.templates << File.expand_path('../templates', __dir__)
  end
end
