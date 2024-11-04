class Showtime < ApplicationRecord
  belongs_to :movie
  has_many :reservations, dependent: :destroy
  has_many :seats, dependent: :destroy
  has_many :reserved_users, through: :reservations, source: :user

  validates :movie, presence: true
  validates :start_time, :end_time, :date, :capacity, presence: true
  validate :no_overlapping_showtimes, :end_time_after_start_time

  before_validation :set_default_end_time, on: :create

  def set_default_end_time
    self.end_time ||= start_time + 2.hours if start_time.present?
  rescue NoMethodError
    errors.add(:base, "Failed to set default end time")
  end

  def reserved_seats
    reservations.where(status: 'reserved').count
  rescue NoMethodError
    errors.add(:base, "Failed to count reserved seats")
    0
  end

  def available_seats
    [capacity - reserved_seats, 0].max # Prevents negative seat count
  rescue NoMethodError
    errors.add(:base, "Failed to count available seats")
    0
  end

  def no_overlapping_showtimes
    return unless movie.present? && start_time.present? && end_time.present?

    overlapping_showtimes = movie.showtimes.where.not(id: id).where(
      "start_time < ? AND end_time > ?", end_time, start_time
    ).exists?

    if overlapping_showtimes
      errors.add(:base, "Showtime overlaps with another showing of this movie")
    end
  end

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?
    if end_time <= start_time
      errors.add(:end_time, "must be after the start time")
    end
  end
end
