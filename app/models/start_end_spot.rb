class StartEndSpot < ApplicationRecord
  belongs_to :plan
  belongs_to :planned_spot

  validates :start_spot, presence: true
  validates :end_spot, presence: true
end