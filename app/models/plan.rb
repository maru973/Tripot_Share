class Plan < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }

  validate :start_date_before_end_date, if: -> { start_date.present? && end_date.present? } 

  private

  def start_date_before_end_date
    if start_date >= end_date
      errors.add(:start_date, '旅行終了日より前の日付に設定してください。')
    end
  end
end
