require 'rails_helper'

RSpec.describe Plan, type: :model do
  it '全フィールドが入力されている場合有効になること' do
    plan = build(:plan)
    expect(plan).to be_valid
  end

  it 'プラン名が空欄の場合は無効になること' do
    plan = build(:plan)
    plan.name = nil
    plan.valid?
    expect(plan.errors[:name]).to include('を入力してください')
  end

  it '行き先が空欄の場合は無効になること' do
    plan = build(:plan)
    plan.location = nil
    plan.valid?
    expect(plan.errors[:location]).to include('を入力してください')
  end

  it '出発日が到着日より後の日付の場合無効になること' do
    plan = build(:plan)
    plan.start_date = Date.tomorrow + 8.days
    plan.valid?
    expect(plan.errors[:start_date]).to include('は旅行終了日より前の日付に設定してください')
  end

  it '出発日が今日以前の場合無効になること' do
    plan = build(:plan)
    plan.start_date = Date.yesterday
    plan.valid?
    expect(plan.errors[:start_date]).to include('は今日以降の日付に設定してください')
  end

  it '到着日今日以前の場合無効になること' do
    plan = build(:plan)
    plan.start_date = nil
    plan.end_date = Date.yesterday
    plan.valid?
    expect(plan.errors[:end_date]).to include('は今日以降の日付に設定してください')
  end 
end
