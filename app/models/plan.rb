class Plan < ApplicationRecord
  validates :name, presence: true, length: { maximum: 255 }
end
