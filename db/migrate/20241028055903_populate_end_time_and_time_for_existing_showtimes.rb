class PopulateEndTimeAndTimeForExistingShowtimes <
  def up
    Showtime.where(end_time: nil).find_each do |showtime|
      if showtime.start_time.present?
        showtime.update(
          end_time: showtime.start_time + 2.hours,
          time: showtime.start_time
        )
      end
    end
  end

  def down
    # Optionally, clear these fields if you need to reverse the migration
    Showtime.update_all(end_time: nil, time: nil)
  end
end
