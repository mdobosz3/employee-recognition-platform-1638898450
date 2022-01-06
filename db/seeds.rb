# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
employee_1 = Employee.create(email: "jedynka@gmail.com", password: "111111")
employee_2 = Employee.create(email: "dwojka@gmail.com", password: "222222")
employee_3 = Employee.create(email: "trojka@gmail.com", password: "333333")
employee_4 = Employee.create(email: "czworka@gmail.com", password: "444444")
employee_5 = Employee.create(email: "piatka@gmail.com", password: "555555")

kudo1 = Kudo.create! :title => Faker::Beer.style, :content => Faker::Coffee.notes, :giver_id => 1, :receiver_id => 5
kudo2 = Kudo.create! :title => Faker::Beer.style, :content => Faker::Coffee.notes, :giver_id => 2, :receiver_id => 4
kudo3 = Kudo.create! :title => Faker::Beer.style, :content => Faker::Coffee.notes, :giver_id => 3, :receiver_id => 3
kudo4 = Kudo.create! :title => Faker::Beer.style, :content => Faker::Coffee.notes, :giver_id => 4, :receiver_id => 2
kudo5 = Kudo.create! :title => Faker::Beer.style, :content => Faker::Coffee.notes, :giver_id => 5, :receiver_id => 1