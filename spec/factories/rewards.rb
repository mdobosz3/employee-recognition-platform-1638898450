# frozen_string_literal: true

FactoryBot.define do
  factory :reward do
    title { Faker::JapaneseMedia::DragonBall.character }
    description { Faker::Movies::Hobbit.quote }
    price { '1' }
  end
end
