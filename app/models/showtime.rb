class Showtime < ApplicationRecord
  belongs_to :movie
  has_many :reservations, dependent: :destroy
  has_many :seats, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user

  validates :start_time, :end_time, :date, :capacity, presence: true
  validate :no_overlapping_showtimes, :end_time_after_start_time

  before_validation :set_default_end_time, on: :create

  def set_default_end_time
    self.end_time ||= start_time + 2.hours if start_time.present?
  end

  def reserved_seats
    reservations.where(status: 'reserved').count
  end

  def available_seats
    [capacity - reserved_seats, 0].max # Prevents negative seat count
  end

  def no_overlapping_showtimes
    if movie.showtimes.where.not(id: id).exists?([
      "(start_time, end_time) OVERLAPS (?, ?)",
      start_time, end_time
    ])
      errors.add(:base, 'Showtime conflicts with an existing showtime.')
    end
  end

  def end_time_after_start_time
    if end_time.present? && end_time <= start_time
      errors.add(:end_time, 'must be after the start time.')
    end
  end
end