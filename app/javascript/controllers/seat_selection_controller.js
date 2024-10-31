import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["seat", "submitButton", "seatInput"]

  connect() {
    this.selectedSeat = null
  }

  select(event) {
    const seatElement = event.currentTarget
    
    // Don't allow selecting reserved seats
    if (seatElement.classList.contains('reserved')) return

    // Remove selected class from all seats
    this.seatTargets.forEach(seat => {
      seat.classList.remove('selected')
    })

    // Add selected class to clicked seat
    seatElement.classList.add('selected')
    
    // Update the hidden input with selected seat number
    this.selectedSeat = seatElement.dataset.seatId
    this.seatInputTarget.value = this.selectedSeat
    
    // Enable the submit button
    this.submitButtonTarget.disabled = false
  }
}
