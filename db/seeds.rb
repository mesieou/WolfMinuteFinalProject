# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

puts "cleaning users, meetings and bookings..."
Booking.destroy_all
Meeting.destroy_all
User.destroy_all

role = ["manager", "employee"]
location = ["Shibuya, Tokyo", "Roppongi, Tokyo", "Shinjuku, Tokyo", "Sapporo", "Osaka", "Kyoto", "Hiroshima"]
creator = [true, false]

test_user = User.create!(
  name: "testuser",
  email: "test@email.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone
)

puts "created test user"

test_meeting = Meeting.create!(
  user: test_user,
  start_date: Date.today + rand(1..3),
  end_date: Date.today + rand(4..6),
  description: Faker::Quote.most_interesting_man_in_the_world,
  location: location.sample,
  duration: rand(1..3)
)

puts "created meating"

test_booking = Booking.create!(
    user: test_user,
    meeting: test_meeting,
    status: "pending"
)
puts "created booking"

5.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    role: role.sample,
    job_title: Faker::Job.title,
    mobile: Faker::PhoneNumber.cell_phone,
    password: "123456"
  )
  puts "created #{User.count} users!"

  meeting = Meeting.create!(
    user: user,
    start_date: Date.today + rand(1..3),
    end_date: Date.today + rand(4..6),
    description: Faker::Quote.most_interesting_man_in_the_world,
    location: location.sample,
    duration: rand(1..3)
  )

  puts "created #{Meeting.count} meetings!"
end

Meeting.find_each do |meeting|
  # create a booking for each user
  User.find_each do |user|
    Booking.create!(
      user: user,
      meeting: meeting,
      status: Booking.statuses.keys.sample # or just 'accepted'
    )
  end
end

puts "created #{Booking.count} bookings!"
