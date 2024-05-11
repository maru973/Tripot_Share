class Plan < ApplicationRecord
  has_many :planned_spots, dependent: :destroy
  has_many :spots, through: :planned_spots
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :members, dependent: :destroy
  has_many :users, through: :members

  validates :name, presence: true, length: { maximum: 255 }

  validate :dates_check

   # トークン生成のためのメソッド
  def generate_token
   self.invitation_token = Devise.friendly_token
   save
  end

  private

  def dates_check
    if start_date.present? && end_date.present?
      if start_date > end_date
        errors.add(:start_date, '旅行終了日より前の日付に設定してください')
        return # ここで返却、以下の処理をスキップする。
      end
    end

    if start_date.present? && start_date < Date.today
      errors.add(:start_date, '今日以降の日付に設定してください')
    end

    if end_date.present? && end_date < Date.today
      errors.add(:end_date, '今日以降の日付に設定してください')
    end
  end
end
