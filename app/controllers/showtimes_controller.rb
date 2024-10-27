class ShowtimesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin, only: %i[new create edit update destroy]
  before_action :set_showtime, only: %i[show edit update destroy]

  def index
    @movie = Movie.find(params[:movie_id]) # Find the specific movie
    @showtimes = @movie.showtimes           # Get the showtimes for that movie
    @movies = Movie.all                      # Get all movies for display
  end
  def new
    @movie = Movie.find(params[:movie_id])
    @showtime = @movie.showtimes.new
  end

  def create
    @movie = Movie.find(params[:movie_id])
    @showtime = @movie.showtimes.new(showtime_params)
    if @showtime.save
      redirect_to movie_path(@movie), notice: 'Showtime was successfully created.'
    else
      render :new
    end
  end

  def edit; end

  def update
    if @showtime.update(showtime_params)
      redirect_to movie_path(@showtime.movie), notice: 'Showtime updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @showtime.destroy
    redirect_to movie_path(@showtime.movie), notice: 'Showtime deleted successfully.'
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
  end

  private

def showtime_params
  params.require(:showtime).permit(:start_time, :end_time) # Add any other fields you may have
end

end