require 'rails_helper'

RSpec.describe "Plans", type: :system do
  before do
    driven_by(:rack_test)
  end

  let(:user) { create(:user) }
  let(:plan) { create(:plan, owner: user) }

  describe 'みんなのプラン一覧' do
    it 'ヘッダーリンクからみんなのプラン一覧ページに遷移すること' do
      visit '/users/sign_in'
      click_on 'みんなのプランをみる'
      Capybara.assert_current_path('/plans', ignore_query: true)
      expect(current_path).to eq('/plans'), 'ヘッダーのリンクをクリックしてもみんなのプラン一覧ページに遷移できません'
      expect(page).to have_content('みんなのプラン'), '「みんなのプラン」の文言が表示されていません'
    end

    context 'プランが1件もない場合' do
      it 'プランがない文言が表示されること' do
        visit '/plans'
        expect(page).to have_content('プランがありません'), '「プランがありません」の文言が表示されていません'
      end
    end

    context 'プランがある場合' do
      it '一覧が表示されること' do
        plan
        visit '/plans'
        expect(page).to have_content(plan.name), 'みんなのプランページにプラン名が表示されていません'
        expect(page).to have_content(plan.location), 'みんなのプランページに行き先が表示されていません'
        expect(page).to have_content(plan.start_date), 'みんなのプランページに出発日が表示されていません'
        expect(page).to have_content(plan.end_date), 'みんなのプランページに到着日が表示されていません'
      end
    end

    context 'プランが6件以下の場合' do
      let!(:plans) { create_list(:plan, 6, owner: user) }
      it 'ページングが表示されないこと' do
        visit '/plans'
        expect(page).not_to have_selector('.pagination')
      end
    end

    context 'プランが7件以上の場合' do
      let!(:plans) { create_list(:plan, 7, owner: user) }
      it 'ページングが表示されること' do
        visit '/plans'
        expect(page).to have_selector('.pagination'), 'プランが7件以上ある場合にページネーションが表示されていません'
      end
    end
  end

  describe 'マイプラン' do
    context 'ログイン済み' do
      let!(:plan) { create(:plan, owner: user) }
      before do
        login_as(user)
        visit '/plans'
        find(".dropdown-bottom").click
        click_link 'マイプラン'
      end

      it 'ヘッダーリンクからマイプランページに遷移すること' do
        find(".dropdown-bottom").click
        click_link 'マイプラン'
        Capybara.assert_current_path('/myplans', ignore_query: true)
        expect(current_path).to eq('/myplans'), 'ヘッダーのリンクをクリックしてもマイプランページに遷移できません'
        expect(page).to have_content('マイプラン'), '「マイプラン」の文言が表示されていません'
      end

      context 'プランが1件もない場合' do
        it 'プランがない文言が表示されること' do
          visit '/myplans'
          expect(page).to have_content('プランがありません'), '「プランがありません」の文言が表示されていません'
        end
      end
  
      context 'プランがある場合' do
        it '一覧が表示されること' do
          Member.create(user: user, plan: plan)
          expect(page).to have_content(plan.name), 'マイプランページにプラン名が表示されていません'
          expect(page).to have_content(plan.location), 'マイプランページに行き先が表示されていません'
          expect(page).to have_content(plan.start_date), 'マイプランページに出発日が表示されていません'
          expect(page).to have_content(plan.end_date), 'マイプランページに到着日が表示されていません'
        end
      end
  
      context 'プランが6件以下の場合' do
        let!(:plans) { create_list(:plan, 6, owner: user) }
        it 'ページングが表示されないこと' do
          plans.each { |plan| Member.create(user: user, plan: plan) }
          visit '/myplans'
          expect(page).not_to have_selector('.pagination')
        end
      end
  
      context 'プランが7件以上の場合' do
        let!(:plans) { create_list(:plan, 7, owner: user) }
        it 'ページングが表示されること' do
          plans.each { |plan| Member.create(user: user, plan: plan) }
          visit '/myplans'
          expect(page).to have_selector('.pagination'), 'プランが7件以上ある場合にページネーションが表示されていません'
        end
      end
    end
  end



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
        expect(current_path).to eq("/plans/#{plan.id}/new_spots"), 'プラン新規作成に成功した時、スポット登録ページにリダイレクトされていません'
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
        visit '/plans/new'
        Capybara.assert_current_path('/users/sign_in', ignore_query: true)
        expect(current_path).to eq('/users/sign_in'), '未ログイン時に、プラン新規作成画面にアクセスした際に、ログインページにリダイレクトされていません'
        expect(page).to have_content('ログインもしくはアカウント登録してください'), 'フラッシュメッセージ「ログインもしくはアカウント登録してください」が表示されていません'
      end
    end
  end
end
