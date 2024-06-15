class Spot < ApplicationRecord
  has_many :planned_spots, dependent: :destroy
  has_many :plans, through: :planned_spots
  has_many :users, through: :planned_spots

  scope :user_spots, ->(plan_id, user_id) {
    joins(:planned_spots).where(planned_spots: { plan_id: plan_id, user_id: user_id })
  }

  scope :ranking_spots, ->(plan_id, spot_ids) {
    joins(:planned_spots).where(id: spot_ids, planned_spots: { plan_id: plan_id }).order('planned_spots.row_order')
  }

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  # Spot.newされたら呼び出す
  after_initialize :set_google_client

  # place_idからスポットの詳細情報を取得する
  def get_spot_details(place_id)
    return nil unless place_id

    spot_details = @client.spot(place_id, fields: 'opening_hours,website,formatted_phone_number', language: 'ja')
    {
      opening_hours: spot_details.opening_hours&.[]('weekday_text'),
      website: spot_details.website ? spot_details.website : nil,
      phone_number: spot_details.formatted_phone_number ? spot_details.formatted_phone_number : nil
    }
  end

  private

  def set_google_client
    # @clientがnilの時は値を代入して、値が入っていればその値をそのまま使う
    @client ||= GooglePlaces::Client.new(ENV['GOOGLEMAPS_API_KEY'])
  end
end
