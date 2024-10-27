class CreateMovies < ActiveRecord::Migration[7.2]
  def change
    create_table :movies do |t|
      t.string :title
      t.text :description
      t.string :genre
      t.string :poster_image_url

      t.timestamps
    end
  end
end
