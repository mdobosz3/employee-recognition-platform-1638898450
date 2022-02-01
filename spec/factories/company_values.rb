# frozen_string_literal: true

FactoryBot.define do
  factory :company_value do
    sequence(:title) { |n| "happy#{n}" }
  end
end
