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
end
