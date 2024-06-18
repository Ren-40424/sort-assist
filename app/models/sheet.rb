class Sheet < ApplicationRecord
  validates :name, presence: true

  belongs_to :workspace
end
