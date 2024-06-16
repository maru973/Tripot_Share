class Spot < ApplicationRecord
  has_many :planned_spots, dependent: :destroy
  has_many :plans, through: :planned_spots
  has_many :users, through: :planned_spots

  scope :user_spots, ->(plan_id, user_id) {
    joins(:planned_spots).where(planned_spots: { plan_id: plan_id, user_id: user_id })
  }

  scope :ranking_spots_in_order_of_course, ->(plan_id, spot_ids) {
    joins(:planned_spots).where(id: spot_ids, planned_spots: { plan_id: plan_id }).order('planned_spots.row_order')
  }

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  # Spot.newされたら呼び出す
  after_initialize :set_google_client

  def self.save_spot(location_name)
    results = Geocoder.search(location_name)
    spot = find_or_initialize_by(place_id: results.first.place_id)

    if spot.new_record?
      spot.name = location_name
      spot.latitude = results.first.coordinates[0]
      spot.longitude = results.first.coordinates[1]
      spot.address = results.first.address

      spot_details = spot.get_spot_details(spot.place_id)
      if spot_details
        spot.opening_hours = spot_details[:opening_hours].split(",").join("\n") if spot_details[:opening_hours].present?
        spot.website = spot_details[:website]
        spot.phone_number = spot_details[:phone_number]
      end
      spot.save
    end

    spot
  end

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
