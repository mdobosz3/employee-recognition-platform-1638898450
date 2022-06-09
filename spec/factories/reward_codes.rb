# frozen_string_literal: true

FactoryBot.define do
  factory :reward_code do
    sequence(:code) { |i| "code#{i}" }
    status { 'unused' }
    reward {}
  end
end
