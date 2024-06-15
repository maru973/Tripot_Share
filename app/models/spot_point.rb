class SpotPoint < ApplicationRecord
  belongs_to :user
  belongs_to :planned_spot

  scope :ranking_spots_with_point, ->(plan_id) {
    joins(:planned_spot).where(planned_spots: { plan_id: plan_id }).group('planned_spots.spot_id').order('SUM(point) DESC').limit(6).sum(:point)
  }

  validates :point, presence: true
end
