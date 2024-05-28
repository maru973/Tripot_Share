class SpotPoint < ApplicationRecord
  belongs_to :user
  belongs_to :planned_spot

  validates :score, presence: true
end
