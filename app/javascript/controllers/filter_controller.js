import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["dateStart", "dateEnd", "list", "sortSelect"]
  
  connect() {
    this.filter()
  }
  
  filter() {
    const startDate = new Date(this.dateStartTarget.value)
    const endDate = new Date(this.dateEndTarget.value)
    const sortBy = this.sortSelectTarget.value
    
    const showtimes = Array.from(this.listTarget.querySelectorAll(".showtime-entry"))
    
    showtimes
      .filter(showtime => {
        const showtimeDate = new Date(showtime.dataset.date)
        return showtimeDate >= startDate && showtimeDate <= endDate
      })
      .sort((a, b) => {
        switch(sortBy) {
          case 'date':
            return new Date(a.dataset.date) - new Date(b.dataset.date)
          case 'capacity':
            return parseInt(a.dataset.capacity) - parseInt(b.dataset.capacity)
          case 'title':
            return a.dataset.title.localeCompare(b.dataset.title)
        }
      })
  }
}
