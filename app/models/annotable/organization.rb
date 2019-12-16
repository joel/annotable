module Annotable
  class Organization < ApplicationRecord
    validates :name, presence: true
  end
end
