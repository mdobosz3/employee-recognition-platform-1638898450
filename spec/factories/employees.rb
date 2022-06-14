# frozen_string_literal: true

FactoryBot.define do
  factory :employee do
    sequence(:first_name) { |n| "Tom#{n}" }
    sequence(:last_name) { |n| "Beil#{n}" }
    sequence(:email) { |n| "test#{n}@test.com" }
    password { 'password' }
    number_of_available_kudos { 10 }
  end
end
