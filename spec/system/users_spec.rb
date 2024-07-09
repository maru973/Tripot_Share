require 'rails_helper'

RSpec.describe "Users", type: :system do
  before do
    driven_by(:rack_test)
  end

  it 'ユーザーが新規登録できること' do
    visit '/users/sign_up'
    expect { 
      fill_in '名前', with: 'テスト'
      fill_in 'メールアドレス', with: 'example@example.com'
      fill_in 'パスワード', with: '12345678'
      fill_in 'パスワード（確認用）', with: '12345678'
      click_button 'アカウント登録'
      Capybara.assert_current_path("/plans", ignore_query: true)
    }.to change { User.count }.by(1)
    expect(page).to have_content('アカウント登録が完了しました'), 'フラッシュメッセージ「アカウント登録が完了しました」が表示されていません'
  end
end
