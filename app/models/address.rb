class Address < ApplicationRecord
  validates :district, :address_from, :sheet_id, presence: true
  validates :address_from, :address_to, format: { with: /^(?!-)(?!.*--)[\d-]+(?<!-)$/, message: '数値とハイフンのみを使用してください' }
  validates :load_place, numericality: true

  belongs_to :sheet
  belongs_to :course, optional: true
end
