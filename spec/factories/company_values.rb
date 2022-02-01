# frozen_string_literal: true

FactoryBot.define do
  factory :company_value do
    #title { 'happy' }
    sequence(:title) { |n| "happy#{n}" }
  end
end
