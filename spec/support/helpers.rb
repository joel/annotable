# frozen_string_literal: true

require 'rspec/rails'

module Annotable
  module RSpec
    module ControllerRoutes
      extend ActiveSupport::Concern
      included do
        routes { ::Annotable::Engine.routes }
      end
    end
  end
end

RSpec.configure do |config|
  %i[routing controller].each do |type|
    config.include Annotable::RSpec::ControllerRoutes, type: type
  end
  config.include Annotable::Engine.routes.url_helpers, type: :request
end

require 'json'

module Annotable
  module RSpecHelpers
    # Parses and returns a deserialized JSON
    #
    # @return [Hash]
    def response_json
      JSON.parse(response.body)
    end
  end
end

RSpec.configure do |config|
  config.include Annotable::RSpecHelpers, type: :request
end

def user_attributes
  first_name = FFaker::Name.first_name.delete("'")
  last_name  = FFaker::Name.last_name.delete("'")

  email = first_name.downcase + '.' + last_name.downcase + FFaker::Internet.email[/@(.*)/]

  {
    name: first_name + ' ' + last_name,
    email: email
  }
end
