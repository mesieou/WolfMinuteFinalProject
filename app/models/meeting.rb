class Meeting < ApplicationRecord
  belongs_to :video, optional: true
  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :users, through: :bookings
  has_many :messages, dependent: :destroy

  validates :description, presence: true
  validates :duration, presence: true
  # validates :objectives, presence: true
  # validates :agenda, presence: true
  validates :location, presence: true
  validates :start_date, presence: true
end
