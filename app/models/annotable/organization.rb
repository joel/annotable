module Annotable
  class Organization < ApplicationRecord
    validates :name, presence: true
    has_many :users
    has_many :reports
  end
end
