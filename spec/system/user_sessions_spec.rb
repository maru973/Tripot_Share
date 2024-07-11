require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  let(:user) { create(:user) }

  it 'ログインができること' do
    visit '/users/sign_in'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: user.password
    click_button 'ログイン'
    Capybara.assert_current_path("/plans", ignore_query: true)
    expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
  end

  context 'ログインができない' do
    it 'パスワードが間違っている場合' do
      visit '/users/sign_in'
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: '1234567'
      click_button 'ログイン'
      expect(page).to have_content('メールアドレスまたはパスワードが違います'), 'フラッシュメッセージ「メールアドレスまたはパスワードが違います」が表示されていません'
    end

    it 'メールアドレスが間違っている場合' do
      visit '/users/sign_in'
      fill_in 'メールアドレス', with: 'sample@example.com'
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      expect(page).to have_content('メールアドレスまたはパスワードが違います'), 'フラッシュメッセージ「メールアドレスまたはパスワードが違います」が表示されていません'
    end
  end

  context 'ログアウト' do
    before do
      login_as(user)
    end

    it 'ログアウトができること' do
      click_on('ログアウト')
      Capybara.assert_current_path("/", ignore_query: true)
      expect(page).to have_content('ログアウトしました'), 'フラッシュメッセージ「ログアウトしました」が表示されていません'
    end
  end
end
