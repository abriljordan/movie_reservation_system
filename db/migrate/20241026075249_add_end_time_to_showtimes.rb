class AddEndTimeToShowtimes < ActiveRecord::Migration[7.2]
  def change
    add_column :showtimes, :end_time, :datetime
  end
end
