require 'rails_helper'

RSpec.describe Course, type: :model do
  it '全フィールドが入力されている場合有効になること' do
    course = build(:course)
    expect(course).to be_valid
  end

  it '全フィールドが空欄の場合無効になること' do
    course = build(:course)
    course.start_location = nil
    course.end_location = nil
    expect(course).to be_invalid
  end

  it '出発地が空欄の場合無効になること' do
    course = build(:course)
    course.start_location = nil
    expect(course).to be_invalid
  end

  it '到着地が空欄の場合無効になること' do
    course = build(:course)
    course.end_location = nil
    expect(course).to be_invalid
  end
end
