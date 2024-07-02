FactoryBot.define do
  factory :plan do
    sequence(:name) { |n| "プラン#{n}" }
    start_date { Date.tomorrow }
    end_date { Date.tomorrow + 7.days }
    location { '京都府' }
    association :owner, factory: :user
  end
end
