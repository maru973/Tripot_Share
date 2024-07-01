require 'rails_helper'

RSpec.describe User, type: :model do
  it '名前、メールアドレスがあり、パスワードは6文字以上であれば有効であること' do
    user = build(:user)
    expect(user).to be_valid
  end

  it '名前、メールアドレス、パスワードが空欄であれば無効であること' do
    user = build(:user)
    user.name = nil
    user.email = nil
    user.password = nil
    user.valid?
    expect(user.errors[:name]).to include('を入力してください')
    expect(user.errors[:email]).to include('を入力してください')
    expect(user.errors[:password]).to include('を入力してください')
  end

  it 'メールアドレスはユニークであること' do
    user1 = create(:user)
    user2 = build(:user)
    user2.email = user1.email
    user2.valid?
    expect(user2.errors[:email]).to include('はすでに存在します')
  end

  it '名前は2文字以上であること' do
    user = build(:user)
    user.name = 'a'
    user.valid?
    expect(user.errors[:name]).to include('は2文字以上で入力してください')
  end

  it 'パスワードは6文字以上であること' do
    user = build(:user)
    user.password = '12345'
    user.password_confirmation = '12345'
    user.valid?
    expect(user.errors[:password]).to include('は6文字以上で入力してください')
  end
end
