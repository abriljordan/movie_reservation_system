class Admin::ShowtimesController < ApplicationController
  before_action :set_movie, only: [:new, :create, :index]
  before_action :set_showtime, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @showtimes = Showtime.all.includes(:movie).page(params[:page]).per(10)
    @movies = Movie.all
  end

  def new
    @showtime = Showtime.new
  end

  def create
    @showtime = Showtime.new(showtime_params)

    if @showtime.save
      redirect_to admin_showtimes_path, notice: 'Showtime was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @movie = @showtime.movie
  end

  def update
    @movie = @showtime.movie
    respond_to do |format|
      if @showtime.update(showtime_params)
        format.html { redirect_to admin_showtimes_path, notice: 'Showtime was successfully updated.' }
        format.json { render json: @showtime, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @showtime.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @showtime.destroy
    redirect_to admin_showtimes_path, notice: 'Showtime deleted successfully.'
  rescue ActiveRecord::InvalidForeignKey => e
    redirect_to admin_showtimes_path, alert: 'The showtime is associated with a reservation and cannot be deleted.'
  end

  private

  def showtime_params
    params.require(:showtime).permit(:start_time, :end_time, :date, :capacity, :movie_id)
  end

  def set_showtime
    @showtime = Showtime.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_showtimes_path, alert: 'The showtime does not exist.'
  end

  def set_movie
    @movie = Movie.find(params[:movie_id]) if params[:movie_id]
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_movies_path, alert: 'The movie does not exist.'
  end

  def authorize_admin
    redirect_to(root_path, alert: 'Not authorized.') unless current_user&.admin?
  end
end