import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["seat", "submitButton", "seatInput"]

  connect() {
    console.log("✅ Seat Selection Controller Connected!")
    this.selectedSeat = null
  }

  select(event) {
    console.log("🎯 Seat Clicked:", event.currentTarget.dataset.seatId)
    const seatElement = event.currentTarget
    
    this.seatTargets.forEach(seat => {
      seat.classList.remove('selected')
      console.log("💫 Removing previous selection")
    })

    seatElement.classList.add('selected')
    console.log("✨ New seat selected:", seatElement.dataset.seatId)
    
    this.selectedSeat = seatElement.dataset.seatId
    this.seatInputTarget.value = this.selectedSeat
    this.submitButtonTarget.disabled = false
    console.log("🔓 Submit button enabled")
  }
}
