require 'rails_helper'

RSpec.describe "UserSessions", type: :system do
  before do
    driven_by(:rack_test)
  end
  
  let(:user) { create(:user) }

  it 'ログインができること' do
    visit '/users/sign_in'
    fill_in 'メールアドレス', with: user.email
    fill_in 'パスワード', with: '12345678'
    click_button 'ログイン'
    Capybara.assert_current_path("/plans", ignore_query: true)
    expect(page).to have_content('ログインしました'), 'フラッシュメッセージ「ログインしました」が表示されていません'
  end

  context 'ログインができない' do
    it 'パスワードが間違っている場合' do

    end

    it 'メールアドレスが間違っている場合' do
    end
  end

  it 'ログアウトができること' do
  end
end
