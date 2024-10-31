class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(showtime: :movie).order('showtimes.date DESC')
  end
  
  def create
    @movie = Movie.find(params[:movie_id])
    @showtime = @movie.showtimes.find(params[:showtime_id])
    @reservation = @showtime.reservations.build(reservation_params)
    @reservation.user = current_user
    
    if @reservation.save
      redirect_to movie_path(@movie), notice: 'Seat reserved successfully!'
    else
      redirect_to movie_showtime_path(@movie, @showtime), alert: 'Unable to reserve seat.'
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:seat_number)
  end
end
