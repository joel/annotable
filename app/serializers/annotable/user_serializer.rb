module Annotable
  class UserSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :email
    belongs_to :organization
  end
end
