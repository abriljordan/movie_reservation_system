class AddTimeToShowtimes < ActiveRecord::Migration[7.2]
  def change
    add_column :showtimes, :time, :datetime
  end
end
