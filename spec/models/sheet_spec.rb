require 'rails_helper'

RSpec.describe Sheet, type: :model do
  before do
    @workspace = FactoryBot.create(:workspace)
    @sheet = FactoryBot.build(:sheet, workspace: @workspace)
  end

  describe 'シート作成' do
    context '作成できるとき' do
      it '情報がすべて適切なら登録できる' do
        expect(@sheet).to be_valid
      end

      it '説明文がなくても登録できる' do
        @sheet.explanation = ''
        expect(@sheet).to be_valid
      end
    end

    context '作成できないとき' do
      it '名前が必須であること' do
        @sheet.name = ''
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include("Name can't be blank")
      end

      it 'Workspaceが紐づいていることが必須であること' do
        @sheet.workspace = nil
        @sheet.valid?
        expect(@sheet.errors.full_messages).to include('Workspace must exist')
      end
    end
  end
end
