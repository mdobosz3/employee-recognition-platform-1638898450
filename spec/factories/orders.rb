# frozen_string_literal: true

FactoryBot.define do
  factory :order do
    employee
    reward
    reward_snapshot { reward }
    status {'not_delivered'}
  end
end
