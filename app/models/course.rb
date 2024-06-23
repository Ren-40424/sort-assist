class Course < ApplicationRecord
  validates :name, presence: true
  validates :create_load_sheet, presence: true
  validates :sheet_id, presence: true

  belongs_to :sheet
end
