class PopulateEndTimeAndTimeForExistingShowtimes < ActiveRecord::Migration[7.2]
  def up
    # Code to populate end_time and time fields for existing showtimes
    Showtime.where(end_time: nil).find_each do |showtime|
      showtime.update!(end_time: showtime.start_time + 2.hours, time: showtime.start_time)
    end
  end

  def down
    # Optionally, clear these fields if you need to reverse the migration
    Showtime.update_all(end_time: nil, time: nil)
  end
end
