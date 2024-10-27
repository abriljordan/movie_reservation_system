# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing records
User.delete_all
Movie.delete_all
Showtime.delete_all

# Create Admin User
admin = User.create!(
  email: 'admin@example.com',
  password: 'password',
  role: 'admin'
)

# Create Regular Users
user1 = User.create!(
  email: 'user1@example.com',
  password: 'password',
  role: 'regular'
)

user2 = User.create!(
  email: 'user2@example.com',
  password: 'password',
  role: 'regular'
)

# Create Movies
movies = [
  { title: 'Inception', description: 'A mind-bending thriller', genre: 'Sci-Fi' },
  { title: 'The Dark Knight', description: 'A superhero thriller', genre: 'Action' },
  { title: 'Interstellar', description: 'A journey beyond the stars', genre: 'Sci-Fi' }
]

movies.each do |movie_data|
  Movie.create!(movie_data)
end

# Create Showtimes for Movies
movies.each_with_index do |movie_data, index|
    movie = Movie.find_by(title: movie_data[:title])
    Showtime.create!(
      movie: movie,
      start_time: DateTime.now + (index + 1).days,
      date: Date.today + (index + 1).days,     # Add a date attribute
      capacity: 50                             # Add capacity as per requirements
    )
  end

puts "Database seeded successfully!"