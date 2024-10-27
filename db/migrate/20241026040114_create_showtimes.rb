class CreateShowtimes < ActiveRecord::Migration[7.2]
  def change
    create_table :showtimes do |t|
      t.references :movie, null: false, foreign_key: true
      t.datetime :start_time
      t.date :date
      t.integer :capacity

      t.timestamps
    end
  end
end
