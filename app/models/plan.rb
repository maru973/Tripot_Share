class Plan < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
  validates :start_date, presence: true
  validates :end_date, presence: true
end
