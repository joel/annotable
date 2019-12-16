module Annotable
  class OrganizationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name
  end
end
