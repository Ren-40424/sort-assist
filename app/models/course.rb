class Course < ApplicationRecord
  validates :name, presence: true
  validates :sheet_id, presence: true

  belongs_to :sheet
  has_many :addresses, dependent: :nullify
end
