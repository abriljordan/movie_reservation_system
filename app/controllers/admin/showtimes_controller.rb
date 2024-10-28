# app/controllers/admin/showtimes_controller.rb
class Admin::ShowtimesController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_movie, only: [:index, :new, :create]
  before_action :set_showtime, only: [:edit, :update, :destroy]

  def index
    @showtimes = @movie ? @movie.showtimes : Showtime.all.includes(:movie)
    @movies = Movie.all
  end

  def new
    @showtime = @movie.showtimes.new
  end

  def create
    @showtime = @movie.showtimes.new(showtime_params)
    @showtime.end_time ||= @showtime.start_time + 2.hours if @showtime.start_time.present?
  
    if @showtime.save
      redirect_to admin_movie_showtimes_path(@movie), notice: 'Showtime created successfully.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @showtime.update(showtime_params)
      redirect_to admin_movie_showtimes_path(@movie), notice: 'Showtime updated successfully.'
    else
      render :edit
    end
  end

  def destroy
    @showtime.destroy
    redirect_to admin_movie_showtimes_path(@movie), notice: 'Showtime deleted successfully.'
  end

  private

  def set_movie
    @movie = Movie.find(params[:movie_id]) if params[:movie_id]
  end

  def set_showtime
    @showtime = Showtime.find(params[:id])
  end

  def showtime_params
    params.require(:showtime).permit(:start_time, :end_time, :capacity, :date)
  end

  def authorize_admin
    redirect_to(root_path, alert: 'Not authorized.') unless current_user.admin?
  end
end