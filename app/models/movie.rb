class Movie < ApplicationRecord
  has_many :showtimes, dependent: :destroy

  validates :title, presence: true, length: { maximum: 100 }
  validates :description, presence: true, length: { maximum: 500 }
  validates :genre, presence: true, inclusion: { in: %w(Action Comedy Drama Horror Sci-Fi Romance), message: "%{value} is not a valid genre" }

  scope :by_genre, ->(genre) { where(genre: genre) }
  scope :recent, -> { order(created_at: :desc) }

  def self.search(query)
    where("title ILIKE ? OR description ILIKE ?", "%#{query}%", "%#{query}%")
  end
end