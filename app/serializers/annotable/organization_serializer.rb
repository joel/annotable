module Annotable
  class OrganizationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name
    has_many :users
  end
end
