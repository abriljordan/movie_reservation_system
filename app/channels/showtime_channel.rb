class ShowtimeChannel < ApplicationCable::Channel
  def subscribed
    stream_from "showtime_#{params[:showtime_id]}"
  end
  
  def update_seats(data)
    showtime = Showtime.find(params[:showtime_id])
    showtime.update!(reserved_seats: data['reserved_seats'])
    
    Turbo::StreamsChannel.broadcast_update_to(
      "showtime_#{showtime.id}",
      target: "showtime_#{showtime.id}_seats",
      partial: "admin/showtimes/seats",
      locals: { showtime: showtime }
    )
  end
end