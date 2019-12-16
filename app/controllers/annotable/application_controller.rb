module Annotable
  class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    include JSONAPI::Deserialization

    private

    # Returns a dictionary with indifferent access of the parsed JSONAPI document
    #
    # @return [Hash]
    def jsonapi_deserialize(req_params, opts = {})
      super(req_params, opts).with_indifferent_access
    end
  end
end
