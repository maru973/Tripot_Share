require 'rails_helper'

RSpec.describe "Plans", type: :system do
  before do
    driven_by(:rack_test)
  end

  describe 'プラン作成' do
    context 'ログイン済み' do
      it 'プランが作成されスポット登録ページに遷移すること' do
      end

      it 'プラン作成ができないこと' do
      end
    end

    context '未ログイン' do
      it 'ログインページにリダイレクトされること' do
      end
    end
  end
end
