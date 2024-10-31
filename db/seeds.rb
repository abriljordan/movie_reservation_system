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

# Create sample movies
movies = [
  {
    title: "Dune: Part Two",
    description: "Paul Atreides unites with Chani and the Fremen while seeking revenge against the conspirators who destroyed his family.",
    genre: "Science Fiction",
    poster_image_url: "https://image.tmdb.org/t/p/w500/8b8R8l88Qje9dn9OE8PY05Nxl1X.jpg",
    published: true
  },
  {
    title: "Kung Fu Panda 4",
    description: "Po must train a new Dragon Warrior while defending the Valley of Peace from a powerful sorceress.",
    genre: "Animation",
    poster_image_url: "https://image.tmdb.org/t/p/w500/kDp1vUBnMpe8ak4rjgl3cLELqjU.jpg",
    published: true
  },
  {
    title: "Ghostbusters: Frozen Empire",
    description: "The Spengler family returns to where it all started – the iconic New York City firehouse – to team up with the original Ghostbusters.",
    genre: "Action/Comedy",
    poster_image_url: "https://image.tmdb.org/t/p/w500/5YZbUmjbMa3ClvSW1Wj3D6XGolb.jpg",
    published: true
  }
]

movies.each do |movie_data|
  movie = Movie.create!(movie_data)
  
  # Create showtimes for each movie
  (0..6).each do |days_from_now|
    date = Date.today + days_from_now
    
    showtimes = [
      { start: "10:00", end: "12:30" },
      { start: "13:00", end: "15:30" },
      { start: "16:00", end: "18:30" },
      { start: "19:00", end: "21:30" },
      { start: "22:00", end: "23:59" }
    ]

    showtimes.each do |show|
      start_datetime = DateTime.parse("#{date} #{show[:start]}")
      end_datetime = DateTime.parse("#{date} #{show[:end]}")
      
      Showtime.create!(
        movie: movie,
        date: date,
        time: start_datetime,
        start_time: start_datetime,
        end_time: end_datetime,
        capacity: 50
      )
    end
  end
end
