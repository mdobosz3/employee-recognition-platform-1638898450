# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { 'title kudo' }
    content { 'content' }
    giver factory: :employee
    receiver factory: :employee
  end
end
