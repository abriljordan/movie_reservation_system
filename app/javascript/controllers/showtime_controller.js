import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["capacity", "available", "reserved"]

  connect() {
    console.log("Showtime controller connected")
    this.updateAvailable() // Initialize available seats on connect
  }

  updateAvailable() {
    const capacity = parseInt(this.capacityTarget.value)
    const reserved = parseInt(this.reservedTarget.value) || 0 // Ensure reserved value is tracked
    this.availableTarget.textContent = capacity - reserved
  }
}
