require 'rails_helper'

RSpec.describe Course, type: :model do
  before do
    @sheet = FactoryBot.create(:sheet)
    @course = FactoryBot.build(:course, sheet: @sheet)
  end

  describe 'コース作成機能' do
    context '作成できるとき' do
      it 'すべての情報が適切なら登録できる' do
        expect(@course).to be_valid
      end

      it '説明文がなくても登録できる' do
        @course.explanation = ''
        expect(@course).to be_valid
      end
    end

    context '作成できないとき' do
      it '名前が必須であること' do
        @course.name = ''
        @course.valid?
        expect(@course.errors.full_messages).to include("Name can't be blank")
      end

      it 'Sheetが紐づいていることが必須であること' do
        @course.sheet = nil
        @course.valid?
        expect(@course.errors.full_messages).to include('Sheet must exist')
      end
    end
  end
end
