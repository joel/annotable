module Annotable
  class User < ApplicationRecord
    belongs_to :organization, optional: true
    validates :email, presence: true, format: { with: /@/ }
  end
end
