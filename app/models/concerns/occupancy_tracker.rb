module OccupancyTracker
  extend ActiveSupport::Concern

  included do
    after_commit :broadcast_occupancy_updates
    
    def current_occupancy_rate
      ((reserved_seats.to_f / capacity) * 100).round(2)
    end
    
    def revenue_potential
      available_seats * calculated_optimal_price
    end
  end
end
