# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

def set_user(email: Faker::Internet.email, passwd: 'abcdabcdab', role: :user)
  {
    email: email,
    password: passwd,
    password_confirmation: passwd,
    role: role
  }
end

unless User.any?
  u = User.new(set_user(email: 'admin@example.com', role: :admin))
  u.save
  5.times do
    u = User.new(set_user)
    u.save
  end
end
