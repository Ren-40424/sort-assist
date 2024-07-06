class Address < ApplicationRecord
  validates :district, :sheet_id, presence: true
  validates :load_place, numericality: true

  validate  :validate_address
  validate  :presence_of_other

  belongs_to :sheet
  belongs_to :course, optional: true

  private

  def validate_address
    validate_address_format(:address_from)
    validate_address_format(:address_to)
  end

  def validate_address_format(attr)
    value = send(attr)
    return if value.blank?

    errors.add(attr, '数値とハイフンのみを使用してください。') unless value =~ /\A[\d-]+\z/

    return unless value =~ /--/ || value.start_with?('-') || value.end_with?('-')

    errors.add(attr, 'ハイフンの位置が正しくありません。')
  end

  def presence_of_other
    return unless address_to.present? && address_from.blank?

    errors.add(:address_from, '範囲指定が不要な場合は「から」の側にのみ入力してください。')
  end
end
