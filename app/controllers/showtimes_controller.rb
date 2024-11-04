class ShowtimesController < ApplicationController
  before_action :authenticate_user!
  
  def index
    @showtimes = Showtime.where("date >=?", Time.current)
  end
    
  def show
    @movie = Movie.find(params[:movie_id])
    @showtime = @movie.showtimes.find(params[:id])
    @seats = @showtime.seats.order(:seat_number)
  end
end
