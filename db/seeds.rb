# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

1.upto(5) do |i|
  kudo = Employee.create(email: "test#{i}@test.com", password: "password")
end

  AdminUser.create(email: "admin@admin.com", password: "password")

1.upto(4) do |i|
  kudo = Kudo.create(title: Faker::Beer.style, content: Faker::Coffee.notes, giver_id: "#{i}", receiver_id: "#{i+1}")
end
