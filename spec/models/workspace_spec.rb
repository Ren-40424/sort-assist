require 'rails_helper'

RSpec.describe Workspace, type: :model do
  before do
    @workspace = FactoryBot.build(:workspace)
  end

  describe 'ワークスペース作成' do
    context '作成できるとき' do
      it '情報が適切なら登録できる' do
        expect(@workspace).to be_valid
      end

      it '説明文がなくても登録できる' do
        @workspace.explanation = ''
        expect(@workspace).to be_valid
      end
    end

    context '作成できないとき' do
      it '名前が必須であること' do
        @workspace.name = ''
        @workspace.valid?
        expect(@workspace.errors.full_messages).to include("Name can't be blank")
      end
    end
  end
end
