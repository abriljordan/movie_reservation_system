class AddPublishedToMovies < ActiveRecord::Migration[7.2]
  def change
    add_column :movies, :published, :boolean
  end
end
