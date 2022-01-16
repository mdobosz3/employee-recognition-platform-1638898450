FactoryBot.define do
  factory :employee do
    sequence (:email) { |n| "test#{n}@test.com" }
    password { 'password' }
  end
end
