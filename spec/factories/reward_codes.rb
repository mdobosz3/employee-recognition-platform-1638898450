# frozen_string_literal: true

FactoryBot.define do
  factory :reward_code do
    sequence(:code) { |i| "code#{i}" }
    sale { 'unused' }
    reward {}
  end
end
