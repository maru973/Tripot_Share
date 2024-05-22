class Plan < ApplicationRecord
  has_many :planned_spots, dependent: :destroy
  has_many :spots, through: :planned_spots
  belongs_to :owner, class_name: 'User', foreign_key: 'owner_id'
  has_many :members, dependent: :destroy
  has_many :users, through: :members

  validates :name, presence: true, length: { maximum: 100 }
  validates :location, presence: true

  validate :dates_check

  JAPAN_PREFECTURES = [ "北海道", "青森県", "岩手県", "宮城県", "秋田県", 
    "山形県", "福島県", "茨城県", "栃木県", "群馬県", "埼玉県", "千葉県", "東京都", 
    "神奈川県", "新潟県", "富山県", "石川県", "福井県", "山梨県", "長野県", "岐阜県", 
    "静岡県", "愛知県", "三重県", "滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", 
    "和歌山県", "鳥取県", "島根県", "岡山県", "広島県", "山口県", "徳島県", "香川県", 
    "愛媛県", "高知県", "福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", 
    "鹿児島県", "沖縄県" 
  ]


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

  def self.ransackable_attributes(auth_object = nil)
    ["name", "location"]
  end
end
