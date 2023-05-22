class User < ApplicationRecord
  has_many :bookings, dependent: :destroy
  has_many :meetings, through: :bookings
  # has_one_attached :photo

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
end
