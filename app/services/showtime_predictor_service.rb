class ShowtimePredictorService
  def initialize(showtime)
    @showtime = showtime
  end

  def predict_attendance
    historical_data = @showtime.movie.showtimes
      .where(start_time: (Time.current - 30.days)..Time.current)
      .pluck(:capacity, :reserved_seats)
      
    calculate_prediction(historical_data)
  end
  
  def suggest_optimal_capacity
    day_of_week = @showtime.start_time.strftime("%A").downcase
    time_slot = get_time_slot(@showtime.start_time)
    
    similar_showtimes = Showtime
      .where("EXTRACT(DOW FROM start_time) = ?", @showtime.start_time.wday)
      .where("EXTRACT(HOUR FROM start_time) BETWEEN ? AND ?", time_slot.begin, time_slot.end)
      
    calculate_optimal_capacity(similar_showtimes)
  end
end
