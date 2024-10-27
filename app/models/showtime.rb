# app/models/showtime.rb
class Showtime < ApplicationRecord
  belongs_to :movie
  has_many :reservations, dependent: :destroy
  has_many :seats, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user

  validates :start_time, :date, :capacity, presence: true
end