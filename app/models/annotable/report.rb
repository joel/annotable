module Annotable
  class Report < ApplicationRecord
    belongs_to :organization
    validates :name, presence: true
  end
end
