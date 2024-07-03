FactoryBot.define do
  factory :course do
    start_location { '京都駅' }
    end_location { '大宮駅' }
    association :plan
  end
end
