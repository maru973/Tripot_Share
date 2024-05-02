class PlannedSpot < ApplicationRecord
  belongs_to :plan
  belongs_to :spot
end
