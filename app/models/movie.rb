# app/models/movie.rb
class Movie < ApplicationRecord
    has_many :showtimes, dependent: :destroy
  
    validates :title, :description, :genre, presence: true
  end