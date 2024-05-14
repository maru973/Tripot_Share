class PlannedSpot < ApplicationRecord
  belongs_to :plan
  belongs_to :spot
  belongs_to :user
end
