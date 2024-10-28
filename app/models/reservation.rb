class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :showtime

  # Enum for status; assuming 0 = unreserved, 1 = reserved
  enum status: { unreserved: 0, reserved: 1 }
  
  validates :seat_number, presence: true, uniqueness: { scope: :showtime_id }
  validates :status, presence: true
  validate :seat_number_uniqueness_within_showtime

  scope :by_showtime, ->(showtime_id) { where(showtime_id: showtime_id) }
  scope :by_date, ->(date) { joins(:showtime).where(showtimes: { date: date }) }

  private

  def seat_number_uniqueness_within_showtime
    if Reservation.where(seat_number: seat_number, showtime_id: showtime_id).exists?
      errors.add(:seat_number, 'has already been reserved for this showtime.')
    end
  end
end