class PlannedSpot < ApplicationRecord
  belongs_to :plan
  belongs_to :spot
  belongs_to :user
  has_many :spot_points, dependent: :destroy
  has_many :courses, dependent: :destroy
end
