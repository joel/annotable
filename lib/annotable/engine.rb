module Annotable
  class Engine < ::Rails::Engine
    isolate_namespace Annotable
    config.generators.api_only = true
  end
end
