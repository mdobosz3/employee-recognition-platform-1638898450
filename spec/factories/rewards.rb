# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    sequence(:title) { |i| "Faker::JapaneseMedia::DragonBall.character#{i}" }
    description { Faker::Creature::Animal.name }
    sequence(:price, &:to_s)
  end
end
