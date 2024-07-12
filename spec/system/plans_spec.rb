require 'rails_helper'

RSpec.describe "Plans", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }

  describe 'プラン作成' do
    context 'ログイン済み' do
      before do
        login_as(user)
        visit '/plans'
        click_link '旅行プランをつくる'
      end

      it 'プランが作成されスポット登録ページに遷移すること' do
        expect { 
          fill_in 'プラン名', with: 'プラン１'
          find("option[value='京都府']").select_option
          click_button '作成'
        }.to change { Plan.count }.by(1)
        plan = Plan.last
        Capybara.assert_current_path("/plans/#{plan.id}/new_spots", ignore_query: true)
        expect(page).to have_content("#{plan.name}を作成しました"), 'フラッシュメッセージ「#{プラン名}を作成しました」が表示されていません'
        expect(page).to have_content('スポット登録'), '「スポット登録」の文言が表示されていません'
      end

      it 'プラン作成ができないこと' do
        expect { 
          fill_in 'プラン名', with: 'プラン１'
          click_button '作成'
        }.to change { Plan.count }.by(0)
        expect(page).to have_content('プランを作成出来ませんでした'), 'フラッシュメッセージ「プランを作成出来ませんでした」が表示されていません'
        expect(page).to have_content('旅行先の都道府県名を入力してください'), 'エラーメッセージ「旅行先の都道府県名を入力してください」が表示されていません'
      end
    end

    context '未ログイン' do
      it 'ログインページにリダイレクトされること' do
      end
    end
  end
end
