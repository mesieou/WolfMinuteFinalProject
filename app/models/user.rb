class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :meetings, through: :bookings
  has_one_attached :photo

  validates :name, presence: true
  validates :job_title, presence: true
  validates :mobile, presence: true
  validates :role, presence: true
  validates :email, presence: true
  validates :email, uniqueness: true
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

#  def available?(year, month, date, hour)
#   start_date = Time.local(year, month, date, hour).in_time_zone('Tokyo')
#   self.bookings.any? do |booking|
#     p start_date
#     p booking.meeting.start_date.in_time_zone('Tokyo')
#     !(booking.meeting.start_date.in_time_zone('Tokyo') - start_date < 0.003)
#   end
#  end

 def available_time(year, month, day)
  # date = DateTime.now.in_time_zone('Tokyo')
  date = Time.local(year, month, day)
  # date = Time.local(2023, 5, 30, 11, 0)
  today_meetings = self.meetings.where(start_date: date.beginning_of_day..date.end_of_day)
  # today_bookings = self.bookings.select { |booking| booking.meeting.start_date.day == date.day }
  time_slots = (9..18).to_a
  hash = {}
  if today_meetings.count >= 1
  time_slots.each do |hour|
    # available = today_meetings.any? do |meeting|

      # booking.meeting.start_date.in_time_zone('Tokyo').hour != hour && booking.meeting.end_date.in_time_zone('Tokyo').hour != hour || booking.meeting.start_date.in_time_zone('Tokyo').hour < hour && booking.meeting.end_date.in_time_zone('Tokyo').hour <= hour


      # available = today_meetings.find_by("DATE_PART('hour', start_date) = ?", hour) ? false : true

    # end
    hash[hour] = true
    today_meetings.each do |meeting|
    (meeting.start_date.hour...meeting.start_date.hour + meeting.duration.to_i).to_a.each do |hour|
      hash[hour] = false
    end
  end
  end
  hash
else
  time_slots.each do |hour|
    hash[hour] = true
  end
end
hash
end
end
