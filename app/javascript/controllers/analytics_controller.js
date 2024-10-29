import { Controller } from "@hotwired/stimulus"
import Chart from 'chart.js'

export default class extends Controller {
  static targets = ["chart", "trends"]
  
  connect() {
    this.initializeChart()
    this.loadTrends()
  }
  
  initializeChart() {
    const ctx = this.chartTarget.getContext('2d')
    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: this.chartTarget.dataset.labels.split(','),
        datasets: [{
          label: 'Reservations by Day',
          data: this.chartTarget.dataset.values.split(',')
        }]
      }
    })
  }
  
  loadTrends() {
    this.trendsTarget.innerHTML = this.calculateTrends()
  }
}
