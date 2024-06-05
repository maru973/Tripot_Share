class Spot < ApplicationRecord
  has_many :planned_spots, dependent: :destroy
  has_many :plans, through: :planned_spots
  has_many :users, through: :planned_spots



  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }

  # Spot.newされたら呼び出す
  after_initialize :set_google_client

  # place_idを取得する
  def get_place_id(name)
    spot = @client.spots_by_query(name).first
    spot.place_id if spot
  end

  # place_idからスポットの詳細情報を取得する
  def get_spot_details(name)
    place_id = get_place_id(name)
    return nil unless place_id

    spot_details = @client.spot(place_id, fields: 'place_id,opening_hours,website,formatted_phone_number', language: 'ja')
    {
      place_id: spot_details.place_id,
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
