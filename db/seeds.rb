# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.upto(5) do |i|
  employee = Employee.where(email: "test#{i}@test.com").first_or_create!(password: "password")
end

AdminUser.where(email: "admin@admin.com").first_or_create!(password: "password")

1.upto(4) do |i|
  kudo = Kudo.where(title: Faker::Beer.style).first_or_create!(content: Faker::Coffee.notes, giver_id: "#{i}", receiver_id: "#{i+1}", company_value: CompanyValue.all.sample)
end

CompanyValue.where(title: "Patient").first_or_create!
CompanyValue.where(title: "Helpful").first_or_create!

1.upto(15) do |i|
  Reward.where(title: Faker::JapaneseMedia::DragonBall.character).first_or_create!(description: Faker::Movies::Hobbit.quote, price: "#{i}")
end

1.upto(3) do |x|
  Category.where(title: Faker::Games::Heroes.klass).first_or_create!
end
