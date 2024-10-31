class MoviesController < ApplicationController
  def index
    @movies = Movie.where(published: true).order(created_at: :desc)
  end

  def show
    @movie = Movie.find(params[:id])
    @showtimes = @movie.showtimes.order(date: :asc, time: :asc)
  end
end
