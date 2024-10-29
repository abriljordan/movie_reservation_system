import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["capacity", "available"]
  
  connect() {
    console.log("Showtime controller connected")
  }
  
  updateAvailable() {
    const capacity = parseInt(this.capacityTarget.value)
    const reserved = parseInt(this.reservedValue) || 0
    this.availableTarget.textContent = capacity - reserved
  }
}
