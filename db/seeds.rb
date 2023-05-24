# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: “Star Wars” }, { name: “Lord of the Rings” }])
#   Character.create(name: “Luke”, movie: movies.first)
require 'date'
puts "cleaning users, meetings and bookings..."
Booking.destroy_all
Meeting.destroy_all
User.destroy_all

# gender options: 'all' or 'male' or 'female'
gender = 'all'
# age options: 'all' or '12-18' or '19-25' or '26-35' or '35-50' or '50+'
age = '26-35'
# ethnicity options: 'all' or 'asian' or 'white' or 'black' or 'indian' or 'middle_eastern' or 'latino_hispanic'
ethnicity = 'all'

role = ["manager", "employee"]
location = ["room 1", "room 2", "room 3", "room 4", "room 5"]
duration = [15, 20, 30, 60]
now = DateTime.now

test_user = User.create!(
  name: "testuser",
  email: "test@email.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone
)

  url = "https://this-person-does-not-exist.com/new?gender=#{gender}&age=#{age}&etnic=#{ethnicity}"
  json = URI.open(url).read
  src = JSON.parse(json)['src']
  photo_url = "https://this-person-does-not-exist.com#{src}"
  file = URI.open(photo_url)
  test_user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')

puts "created test user"

test_meeting = Meeting.create!(
  title: Faker::Company.buzzword,
  user: test_user,
  start_date: DateTime.new(now.year, now.month, rand(1..29), rand(9..17), [15, 30, 45, 0].sample, 0),
  end_date: Date.today + rand(4..6),
  description: Faker::Company.catch_phrase,
  location: location.sample,
  duration: duration.sample
)


puts "created meating"

test_booking = Booking.create!(
    user: test_user,
    meeting: test_meeting,
    status: "pending"
)
puts "created booking"

20.times do
  user = User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    role: role.sample,
    job_title: Faker::Job.title,
    mobile: Faker::PhoneNumber.cell_phone,
    password: "123456"
  )



    url = "https://this-person-does-not-exist.com/new?gender=#{gender}&age=#{age}&etnic=#{ethnicity}"
    json = URI.open(url).read
    src = JSON.parse(json)['src']
    photo_url = "https://this-person-does-not-exist.com#{src}"
    file = URI.open(photo_url)
    user.photo.attach(io: file, filename: 'user.png', content_type: 'image/png')
    user.save
  puts "created #{User.count} users!"

rand(1..10).times do
  meeting = Meeting.create!(
    title: Faker::Company.buzzword,
    user: user,
    start_date: DateTime.new(now.year, now.month, rand(1..29), rand(9..17), [15, 30, 45, 0].sample, 0),
    end_date: Date.today + rand(4..6),
    description: Faker::Company.catch_phrase,
    location: location.sample,
    duration: duration.sample
  )

end

  puts "created #{Meeting.count} meetings!"
end

Meeting.find_each do |meeting|
  # create a booking for each user
  User.find_each do |user|
    if rand(0..1) == 0
      Booking.create!(
        user: user,
        meeting: meeting,
        status: Booking.statuses.keys.sample # or just 'accepted'
      )
    end
  end
end

puts "created #{Booking.count} bookings!"


# fortesting by Rika start from here!!!

tesuser1 = User.create(
  name: "tes1user",
  email: "tes1@email.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone
)
tesuser2 = User.create(
  name: "tes2user",
  email: "tes2@email.com",
  role: role.sample,
  password: "123456",
  job_title: Faker::Job.title,
  mobile: Faker::PhoneNumber.cell_phone
)
puts "created #{User.count} testusers for Rika"

tesmeeting1 = Meeting.create!(
  title: "for tes1",
  user: tesuser1,
  start_date: Time.local(2023, 5, 23, 9, 0),
  end_date: Time.local(2023, 5, 23, 11, 0),
  description: Faker::Company.catch_phrase,
  location: location.sample,
  duration: 2
)

testbooking1 = Booking.create!(
  user: tesuser1,
  meeting: tesmeeting1
)

tesmeeting2 = Meeting.create!(
  title: "for tes1-2",
  user: tesuser1,
  start_date: Time.local(2023, 5, 23, 15, 0),
  end_date: Time.local(2023, 5, 23, 16, 0),
  description: Faker::Company.catch_phrase,
  location: location.sample,
  duration: 1
)

testbooking1 = Booking.create!(
  user: tesuser1,
  meeting: tesmeeting2
)

tesmeeting3 = Meeting.create!(
  title: "for tes2",
  user: tesuser2,
  start_date: Time.local(2023, 5, 23, 10, 0),
  end_date: Time.local(2023, 5, 23, 13, 0),
  description: Faker::Company.catch_phrase,
  location: location.sample,
  duration: 2
)

testbooking3 = Booking.create!(
  user: tesuser2,
  meeting: tesmeeting3
)

tesmeeting4 = Meeting.create!(
  title: "for tes2-2",
  user: tesuser2,
  start_date: Time.local(2023, 5, 23, 17, 0),
  end_date: Time.local(2023, 5, 23, 18, 0),
  description: Faker::Company.catch_phrase,
  location: location.sample,
  duration: 1
)

testbooking4 = Booking.create!(
  user: tesuser2,
  meeting: tesmeeting4
)

puts "created #{Booking.count} bookings for Rika"
puts "created #{Meeting.count} meetings for Rika"
# fortesting by Rika until here!!!
