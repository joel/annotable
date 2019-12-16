module Annotable
  class OrganizationSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name
    has_many :users
    has_many :reports
  end
end
