class ReservationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_showtime, only: %i[create]
  before_action :set_reservation, only: %i[destroy]

  def create
    @reservation = @showtime.reservations.new(
      user: current_user,
      seat_number: reservation_params[:seat_number],
      status: :reserved
    )

    if seat_available?(@reservation.seat_number) && @reservation.save
      redirect_to @showtime, notice: 'Seat reserved successfully.'
    else
      redirect_to @showtime, alert: 'Seat reservation failed. Please select an available seat.'
    end
  end

  def destroy
    if @reservation.user == current_user
      @reservation.update(status: :canceled)
      redirect_to reservations_path, notice: 'Reservation canceled.'
    else
      redirect_to reservations_path, alert: 'Unauthorized action.'
    end
  end

  private

  def set_showtime
    @showtime = Showtime.find(params[:showtime_id])
  end

  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  def reservation_params
    params.require(:reservation).permit(:seat_number)
  end

  def seat_available?(seat_number)
    @showtime.seats.where(seat_number: seat_number, status: :available).exists?
  end
end