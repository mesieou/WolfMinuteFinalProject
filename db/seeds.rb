# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'date'
puts "cleaning users, meetings and bookings..."
Booking.destroy_all
Meeting.destroy_all
User.destroy_all

role = ["manager", "employee"]
location = ["room 1", "room 2", "room 3", "room 4", "room 5"]
duration = [15, 20, 30, 60]
# random_date = rand(1..29)
# random_hour = rand(9..17)
# random_minute = [15, 30, 60].sample
now = DateTime.now

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
  title: Faker::Company.buzzword,
  user: test_user,
  start_date: DateTime.new(now.year, now.month, rand(1..29), rand(9..17), [15, 30, 60].sample, 0),
  end_date: Date.today + rand(4..6),
  description: Faker::Company.catch_phrase,
  location: location.sample,
  duration: duration.sample
)

p test_meeting.start_date

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

20.times do
  meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: user,
    start_date: DateTime.new(now.year, now.month, rand(1..29), rand(9..17), [15, 30, 60].sample, 0),
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample
  )
  p meeting.start_date
end

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
