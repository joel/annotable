module Annotable
  class ApplicationController < ActionController::API
    # protect_from_forgery with: :exception
    include JSONAPI::Deserialization
    include JSONAPI::Errors
    include JSONAPI::Fetching
    include JSONAPI::Filtering
    include JSONAPI::Pagination

    private

    # Overwrite includes to make sure the whitelisted are used
    #
    # @return [Array] cleaned list of includes
    def jsonapi_include
      return [] unless self.class.respond_to?(:allowed_includes)

      allowed = self.class.public_send(:allowed_includes)
      super & allowed.map(&:to_s)
    end

    # Returns a dictionary with indifferent access of the parsed JSONAPI document
    #
    # @return [Hash]
    def jsonapi_deserialize(req_params, opts = {})
      super(req_params, opts).with_indifferent_access
    end
  end
end
