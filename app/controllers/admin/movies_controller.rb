class Admin::MoviesController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :authorize_admin
  before_action :set_movie, only: [:edit, :update, :show]

  def index
    @movies = Movie.all
  end

  def show
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to admin_movies_path, notice: 'Movie was successfully created.'
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @movie.update(movie_params)
      redirect_to admin_movies_path, notice: 'Movie was successfully updated.'
    else
      render :edit
    end
  end

  private

  def set_movie
    @movie = Movie.find(params[:id])
  end

  def movie_params
    params.require(:movie).permit(:title, :description, :release_date, :director) # Add other permitted attributes as needed
  end

  def authorize_admin
    redirect_to(root_path, alert: 'Not authorized.') unless current_user.admin?
  end
end