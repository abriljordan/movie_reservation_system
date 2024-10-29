class Movie < ApplicationRecord
  has_one_attached :poster_image
  has_many :showtimes, dependent: :destroy

  validates :title, presence: true
  validates :description, presence: true

  before_destroy :check_for_associated_showtimes

  GENRES = [
    'Action',
    'Adventure',
    'Animation',
    'Comedy',
    'Crime',
    'Documentary',
    'Drama',
    'Fantasy',
    'Horror',
    'Musical',
    'Mystery',
    'Romance',
    'Sci-Fi',
    'Thriller',
    'Western'
  ].freeze

  
  private

  def check_for_associated_showtimes
    if showtimes.exists?
      errors.add(:base, "Cannot delete movie with associated showtimes")
      throw(:abort)
    end
  rescue StandardError => e
    errors.add(:base, "An error occurred: #{e.message}")
    throw(:abort)
  end
end
