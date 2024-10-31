import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["seat", "submitButton", "seatInput"]

  connect() {
    console.log("🎯 Seat Selection Controller Connected!")
    console.log("Found seat targets:", this.seatTargets.length)
    console.log("Found submit button:", this.submitButtonTarget)
    this.selectedSeat = null
  }

  select(event) {
    console.log("👆 Seat Clicked:", event.currentTarget.dataset.seatId)
    const seatElement = event.currentTarget
    
    this.seatTargets.forEach(seat => {
      seat.classList.remove('selected')
    })

    seatElement.classList.add('selected')
    this.selectedSeat = seatElement.dataset.seatId
    this.seatInputTarget.value = this.selectedSeat
    this.submitButtonTarget.disabled = false
  }
}
