import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "list"]
  
  connect() {
    this.filterShowtimes()
  }
  
  filterShowtimes() {
    const query = this.inputTarget.value.toLowerCase()
    
    this.listTarget.querySelectorAll(".showtime-entry").forEach(showtime => {
      const movieTitle = showtime.querySelector(".movie-title").textContent.toLowerCase()
      showtime.classList.toggle("hidden", !movieTitle.includes(query))
    })
  }
}
