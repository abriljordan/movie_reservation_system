# app/controllers/admin/showtimes_controller.rb
class Admin::ShowtimesController < ApplicationController
  before_action :set_movie, only: [:new, :create, :index]
  before_action :set_showtime, only: [:show, :edit, :update, :destroy]
  layout 'admin'
  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    
    @showtimes = if @movie
      @movie.showtimes
    else
      Showtime.all
    end
  end

  def new
    @showtime = if @movie
      @movie.showtimes.build
    else
      Showtime.new
    end
  end

  def create
    if params[:movie_id]
      @movie = Movie.find(params[:movie_id])
      @showtime = @movie.showtimes.build(showtime_params)
    else
      @showtime = Showtime.new(showtime_params)
    end

    if @showtime.save
      redirect_to @movie ? admin_movie_path(@movie) : admin_showtimes_path, 
                  notice: 'Showtime was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @showtime.update(showtime_params)
        Turbo::StreamsChannel.broadcast_update_to(
          "showtimes",
          target: dom_id(@showtime),
          partial: "admin/showtimes/showtime",
          locals: { showtime: @showtime }
        )
        format.turbo_stream
        format.html { redirect_to admin_movie_showtimes_path(@movie) }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @showtime.destroy
    redirect_to admin_movie_showtimes_path(@movie), notice: 'Showtime deleted successfully.'
  rescue ActiveRecord::InvalidForeignKey => e
    redirect_to admin_movie_showtimes_path(@movie), alert: 'The showtime is associated with a reservation and cannot be deleted.'
  end

  def total_revenue
    reserved_count = reservations.where(status: 'reserved').count
    reserved_count * ticket_price # Assuming ticket_price is a method or attribute
  end


  private

  def showtime_params
    params.require(:showtime).permit(:start_time, :end_time , :date ,:capacity, :movie_id)
  end

  def set_showtime
    @showtime = Showtime.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to admin_movie_showtimes_path(@movie), alert: 'The showtime does not exist.'
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
