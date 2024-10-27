class CreateSeats < ActiveRecord::Migration[7.2]
  def change
    create_table :seats do |t|
      t.references :showtime, null: false, foreign_key: true
      t.integer :seat_number
      t.integer :status

      t.timestamps
    end
  end
end
