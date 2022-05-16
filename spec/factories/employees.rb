# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    first_name { 'tom' }
    last_name { 'beil' }
    sequence(:email) { |n| "test#{n}@test.com" }
    password { 'password' }
    number_of_available_kudos { 10 }
  end
end
