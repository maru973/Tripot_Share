class PlannedSpot < ApplicationRecord
  include RankedModel
  ranks :row_order

  belongs_to :plan
  belongs_to :spot
  belongs_to :user
  has_many :spot_points, dependent: :destroy
end
