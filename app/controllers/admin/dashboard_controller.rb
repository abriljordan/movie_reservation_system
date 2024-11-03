class Admin::DashboardController < ApplicationController
  layout 'admin'

  before_action :authenticate_user!
  before_action :authorize_admin

  def index
    @showtimes = Showtime.includes(:reservations)
  
# Filter by search term if provided
    if params[:search].present?
      @showtimes = @showtimes.joins(:movie).where("LOWER(movies.title) LIKE ?", "%#{params[:search].downcase}%")
    end
    
    if params[:date_filter].present?
      case params[:date_filter]
      when "today"
        @showtimes = @showtimes.where(date: Date.today)
      when "week"
        @showtimes = @showtimes.where(date: Date.today..Date.today + 7.days)
      when "month"
        @showtimes = @showtimes.where(date: Date.today..Date.today + 1.month)
      end
    end
  end

  private

  def authorize_admin
    redirect_to root_path, alert: 'Not authorized.' unless current_user.admin?
  end
end