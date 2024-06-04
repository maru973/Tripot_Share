class Course < ApplicationRecord
  belongs_to :plan

  validates :start_location, presence: true
  validates :end_location, presence: true
end
