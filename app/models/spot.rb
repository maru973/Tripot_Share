class Spot < ApplicationRecord
  has_many :planned_spots, dependent: :destroy

  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
end
