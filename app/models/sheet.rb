class Sheet < ApplicationRecord
  validates :name,         presence: true
  validates :workspace_id, presence: true

  belongs_to :workspace
  has_many :courses, dependent: :destroy
  has_many :addresses, dependent: :destroy
end
