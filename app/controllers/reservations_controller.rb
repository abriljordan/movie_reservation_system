class ReservationsController < ApplicationController
  before_action :authenticate_user!

  def index
    @reservations = current_user.reservations.includes(showtime: :movie).order('showtimes.date DESC')
  end
  
  def create
    @movie = Movie.find(params[:movie_id])
    @showtime = @movie.showtimes.find(params[:showtime_id])
    
    # Check if the seat is already reserved
    if @showtime.reservations.exists?(seat_number: reservation_params[:seat_number])
      redirect_to movie_showtime_path(@movie, @showtime), alert: 'Seat is already reserved.'
      return
    end

    @reservation = @showtime.reservations.build(reservation_params)
    @reservation.user = current_user
    @reservation.status = :reserved # Set status to reserved

    if @reservation.save
      # Update seat status
      seat = @showtime.seats.find_by(seat_number: reservation_params[:seat_number])
      seat.update(status: :reserved) if seat

      redirect_to movie_path(@movie), notice: 'Seat reserved successfully!'
    else
      redirect_to movie_showtime_path(@movie, @showtime), alert: 'Unable to reserve seat.'
    end
  end

  def destroy
    @movie = Movie.find(params[:movie_id])
    @showtime = @movie.showtimes.find(params[:showtime_id])
    @reservation = @showtime.reservations.find_by(seat_number: params[:id], user: current_user)

    if @reservation
      @reservation.destroy
      # Update seat status
      seat = @showtime.seats.find_by(seat_number: @reservation.seat_number)
      seat.update(status: :available) if seat

      render json: { message: "Seat unreserved successfully." }, status: :ok
    else
      render json: { error: "Reservation not found." }, status: :not_found
    end
  end

  private

  def reservation_params
    params.require(:reservation).permit(:seat_number)
  end
end