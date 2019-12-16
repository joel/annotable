module Annotable
  class ReportSerializer
    include FastJsonapi::ObjectSerializer
    attributes :name, :content
    belongs_to :organization
  end
end
