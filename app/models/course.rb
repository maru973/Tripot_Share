class Course < ApplicationRecord
  belongs_to :plan
  belongs_to :planned_spots

  validates :start_location, presence: true
  validates :end_location, presence: true
end
