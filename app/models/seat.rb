# app/models/seat.rb
class Seat < ApplicationRecord
  belongs_to :showtime

  enum status: { available: 0, reserved: 1 }

  validates :seat_number, presence: true
end