# frozen_string_literal: true

FactoryBot.define do
  factory :kudo do
    title { 'title kudo' }
    content { 'content' }
    giver factory: :employee
    receiver factory: :employee
    company_value factory: :company_value
  end
end
