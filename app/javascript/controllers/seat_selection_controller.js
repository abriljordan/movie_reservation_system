import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["seat", "seatInput", "submitButton"]
  
  connect() {
    this.selectedSeat = null
  }
  
  select(event) {
    const seatElement = event.currentTarget
    
    // Don't allow selecting reserved seats
    if (seatElement.classList.contains('reserved')) {
      return
    }
    
    // Deselect previously selected seat
    if (this.selectedSeat) {
      this.selectedSeat.classList.remove('selected')
    }
    
    // If clicking the same seat, deselect it
    if (this.selectedSeat === seatElement) {
      this.selectedSeat = null
      if (this.seatInputTarget) {
        this.seatInputTarget.value = ''
      }
      if (this.submitButtonTarget) {
        this.submitButtonTarget.disabled = true
      }
      return
    }
    
    // Select new seat
    this.selectedSeat = seatElement
    seatElement.classList.add('selected')
    
    // Update form
    if (this.seatInputTarget) {
      this.seatInputTarget.value = seatElement.dataset.seatId
    }
    if (this.submitButtonTarget) {
      this.submitButtonTarget.disabled = false
    }
  }
}
