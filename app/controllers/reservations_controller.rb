class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_showtime, only: %i[create]
  before_action :set_reservation, only: %i[destroy]

  def index
    @reservations = current_user.reservations.includes(:showtime)
  end
  
  def create
    # Assuming params include movie_id and showtime_id
    @movie = Movie.find(params[:movie_id])
    @showtime = @movie.showtimes.find(params[:showtime_id])
    @reservation = @showtime.reservations.build(reservation_params)
    @reservation.user = current_user

    if @reservation.save
      redirect_to reservations_path, notice: 'Reservation created successfully.'
    else
      render :new, alert: 'Error creating reservation.'
    end
  end

  def destroy
    @reservation = Reservation.find(params[:id])
    @reservation.destroy
    redirect_to reservations_path, notice: 'Reservation canceled successfully.'
  ends

  def set_showtime
    @showtime = Showtime.find(params[:showtime_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  
  private

  def reservation_params
    params.require(:reservation).permit(:seats)
  end

  def seat_available?(seat_number)
    @showtime.seats.where(seat_number: seat_number, status: :available).exists?
  end
end