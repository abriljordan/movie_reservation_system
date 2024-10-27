class MoviesController < ApplicationController
  before_action :authenticate_user!  
  before_action :set_movie, only: %i[show edit update destroy]
  before_action :authorize_admin, except: %i[index show]

  after_action :verify_authorized
  
  def index
    @movies = Movie.all

#    @movies = policy_scope(Movie) # Use policy_scope for index queries
    authorize @movies

  end

  def show
    @movie = Movie.find(params[:id])
    authorize @movie  # This authorizes the @movie instance against the MoviePolicy

    @showtimes = @movie.showtimes
  end

  def new
    @movie = Movie.new
    authorize @movie
  end

  def create
    @movie = Movie.new(movie_params)
    authorize @movie
    if @movie.save
      redirect_to @movie, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def edit
    authorize @movie
  end

  def update
    authorize @movie
    if @movie.update(movie_params)
      redirect_to @movie, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    authorize @movie
    @movie.destroy
    redirect_to movies_url, notice: 'Movie was successfully destroyed.'
  end

  private


  def authorize_admin
    redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
  end
  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :genre, :poster_image)
  end 
end
