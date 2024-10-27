class Admin::ShowtimesController < ApplicationController
    layout 'admin'

    before_action :authenticate_user!
    before_action :authorize_admin

    def index
      @showtimes = Showtime.all
    end

    private

    def authorize_admin
      redirect_to(root_path, alert: 'Not authorized.') unless current_user.admin?
    end
  end

