require 'rails_helper'

RSpec.describe Address, type: :model do
  before do
    @sheet = FactoryBot.create(:sheet)
    @course = FactoryBot.create(:course, sheet: @sheet)
    @address = FactoryBot.build(:address, sheet: @sheet, course: @course)
  end

  describe '住所新規登録' do
    context '登録できるとき' do
      it 'すべての情報が適切なら登録できる' do
        expect(@address).to be_valid
      end

      it 'address_toがなくても登録できる' do
        @address.address_to = ''
        expect(@address).to be_valid
      end

      it 'address_from, address_to両方がなくても登録できる' do
        @address.address_from = ''
        @address.address_to = ''
        expect(@address).to be_valid
      end

      it '名前がなくても登録できる' do
        @address.name = ''
        expect(@address).to be_valid
      end

      it 'コースが紐づいていなくても登録できる' do
        @address.course = nil
        expect(@address).to be_valid
      end
    end

    context '登録できないとき' do
      it '地区名が必須であること' do
        @address.district = ''
        @address.valid?
        expect(@address.errors.full_messages).to include("District can't be blank")
      end

      it 'address_toがある場合、address_fromが必須であること' do
        @address.address_from = ''
        @address.valid?
        expect(@address.errors.full_messages).to include('Address from 範囲指定が不要な場合は「から」の側にのみ入力してください。')
      end

      it 'load_placeは数値以外では保存できない' do
        @address.load_place = 'abc'
        @address.valid?
        expect(@address.errors.full_messages).to include('Load place is not a number')
      end

      it '表が紐づいていることが必須であること' do
        @address.sheet = nil
        @address.valid?
        expect(@address.errors.full_messages).to include('Sheet must exist')
      end
    end
  end
end
