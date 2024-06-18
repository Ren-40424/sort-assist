class Sheet < ApplicationRecord
  validates :name,         presence: true
  validates :workspace_id, presence: true

  belongs_to :workspace
end
