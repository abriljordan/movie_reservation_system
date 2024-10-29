import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["gauge", "revenue", "price"]
  static values = { 
    showtimeId: String,
    occupancy: Number,
    basePrice: Number
  }

  connect() {
    this.initializeGauge()
    this.startRealtimeUpdates()
    this.optimizePrice()
  }

  initializeGauge() {
    // Initialize D3.js gauge visualization
    this.gauge = new Gauge(this.gaugeTarget, {
      min: 0,
      max: 100,
      value: this.occupancyValue
    })
  }

  optimizePrice() {
    const occupancyRate = this.occupancyValue
    const basePrice = this.basePriceValue
    
    // Dynamic pricing based on occupancy
    const multiplier = 1 + (occupancyRate / 100)
    const optimizedPrice = basePrice * multiplier
    
    this.priceTarget.textContent = `$${optimizedPrice.toFixed(2)}`
  }
}
