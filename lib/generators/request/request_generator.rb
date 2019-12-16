require 'generators/rspec/request/request_generator'

class RequestGenerator < Rspec::Generators::RequestGenerator
  argument :attributes,
           type: :array,
           default: [],
           banner: 'field:type field:type'

  source_root File.expand_path('templates', __dir__)

  # Parse and copy ERB template
  # @return [NilClass]
  def generate_request_spec
    template 'request_spec.rb', File.join('spec/requests', "#{name.underscore.pluralize}_spec.rb")
  end
end
