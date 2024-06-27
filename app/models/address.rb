class Address < ApplicationRecord
  validates :district, :address_from, :sheet_id, presence: true
  validates :address_from, format: { with: /\A(?!-)(?!.*--)[\d-]+(?<!-)\z/, message: '数値とハイフンのみを使用してください' }
  validates :address_to,   format: { with: /\A(?!-)(?!.*--)[\d-]+(?<!-)\z/, message: '数値とハイフンのみを使用してください' }, allow_blank: true
  validates :load_place, numericality: true

  belongs_to :sheet
  belongs_to :course, optional: true
end
