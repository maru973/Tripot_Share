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

  context 'ユーザーの新規新規登録できない' do
    it '空欄箇所がある場合' do
      visit '/users/sign_up'
      expect { 
        fill_in '名前', with: 'テスト'
        click_button 'アカウント登録'
      }.to change { User.count }.by(0)
      expect(page).to have_content('メールアドレスを入力してください'), 'エラーメッセージ「メールアドレスを入力してください」が表示されていません'
      expect(page).to have_content('パスワードを入力してください'), 'エラーメッセージ「パスワードを入力してください」が表示されていません'
    end

    it 'すでに登録済みの場合' do
      create(:user)
      visit '/users/sign_up'
      expect { 
        fill_in '名前', with: 'テスト'
        fill_in 'メールアドレス', with: 'example@example.com'
        fill_in 'パスワード', with: '12345678'
        fill_in 'パスワード（確認用）', with: '12345678'
        click_button 'アカウント登録'
      }.to change { User.count }.by(0)
      expect(page).to have_content('メールアドレスはすでに存在します'), 'エラーメッセージ「メールアドレスはすでに存在します」が表示されていません'
    end
  end

end
