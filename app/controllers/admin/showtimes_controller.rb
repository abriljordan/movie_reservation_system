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
    if @movie
      @showtime = @movie.showtimes.new
    else
      @showtime = Showtime.new
    end  
  end

  def create
    @showtime = @movie.showtimes.new(showtime_params)
  
    respond_to do |format|
      if @showtime.save
        format.turbo_stream { 
          render turbo_stream: [
            turbo_stream.append("showtimes", partial: "showtime", locals: { showtime: @showtime }),
            turbo_stream.update("new_showtime", "")
          ]
        }
        format.html { redirect_to admin_movie_showtimes_path(@movie) }
      else
        format.html { render :new }
      end
    end
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