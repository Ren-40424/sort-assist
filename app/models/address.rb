class Address < ApplicationRecord
  validates :district, :sheet_id, presence: true
  validates :address_from, :address_to,
            format: { with: /\A(?!-)(?!.*--)[\d-]+(?<!-)\z/, message: '数値とハイフンのみを使用してください。' },
            allow_blank: true
  validates :load_place, numericality: true

  validate  :presence_of_other

  belongs_to :sheet
  belongs_to :course, optional: true

  private

  def presence_of_other
    return unless address_to.present? && address_from.blank?

    errors.add(:address_from, '範囲指定が不要な場合は「から」の側にのみ入力してください。')
  end
end
