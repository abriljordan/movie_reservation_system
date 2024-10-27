# app/models/reservation.rb
class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :showtime

  enum status: { reserved: 'reserved', canceled: 'canceled' }

  validates :seat_number, presence: true, uniqueness: { scope: :showtime_id }
  validates :status, presence: true
  validate :seat_number_uniqueness_within_showtime

  scope :by_showtime, ->(showtime_id) { where(showtime_id: showtime_id) }
  scope :by_date, ->(date) { joins(:showtime).where(showtimes: { date: date }) }
  
end