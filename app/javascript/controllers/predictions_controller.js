import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["attendance", "capacity"]
  
  connect() {
    this.loadPredictions()
    this.setupOptimizationSlider()
  }
  
  loadPredictions() {
    fetch(`/api/predictions/${this.element.dataset.showtimeId}`)
      .then(response => response.json())
      .then(data => {
        this.updatePredictionDisplay(data)
      })
  }
  
  updatePredictionDisplay(data) {
    this.attendanceTarget.textContent = `${data.predicted_attendance}%`
    this.capacityTarget.value = data.optimal_capacity
  }
}
