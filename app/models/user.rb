class User < ApplicationRecord
  has_many :plans, foreign_key: 'owner_id'
  has_many :members, dependent: :destroy
  has_many :plans, through: :members
  has_many :planned_spots, dependent: :destroy
  has_many :spots, through: :planned_spots
  has_many :spot_rankings

  mount_uploader :avatar, AvatarUploader

  attr_accessor :plan_id

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: %i[line]

  validates :name, presence: true, length: { minimum: 2 }

  def set_values(omniauth)
    return if provider.to_s != omniauth["provider"].to_s || uid != omniauth["uid"]
    credentials = omniauth["credentials"]
    info = omniauth["info"]

    access_token = credentials["refresh_token"]
    access_secret = credentials["secret"]
    credentials = credentials.to_json
    name = info["name"]
  end

  # planのメンバーかどうかを判断するメソッド
  def member?(plan_id)
    self.plans.find_by(id: plan_id).present?
  end
end
