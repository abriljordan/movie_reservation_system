import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["table", "search", "dateFilter"]
  
  connect() {
    this.sortDirection = {}
  }
  
  sort(event) {
    const key = event.currentTarget.dataset.sortKey
    const rows = Array.from(this.tableTarget.querySelectorAll("tbody tr"))
    
    this.sortDirection[key] = this.sortDirection[key] === 'asc' ? 'desc' : 'asc'
    
    const sortedRows = rows.sort((a, b) => {
      let aVal = a.querySelector(`[data-sort-${key}]`).dataset[`sort${key}`]
      let bVal = b.querySelector(`[data-sort-${key}]`).dataset[`sort${key}`]
      
      return this.sortDirection[key] === 'asc' ? 
        aVal.localeCompare(bVal) : 
        bVal.localeCompare(aVal)
    })
    
    this.tableTarget.querySelector("tbody").innerHTML = ""
    sortedRows.forEach(row => this.tableTarget.querySelector("tbody").appendChild(row))
  }
  
  filter() {
    const searchTerm = this.searchTarget.value.toLowerCase()
    const dateFilter = this.dateFilterTarget.value
    const rows = this.tableTarget.querySelectorAll("tbody tr")
    
    rows.forEach(row => {
      const movieTitle = row.querySelector("[data-sort-title]").textContent.toLowerCase()
      const showDate = new Date(row.querySelector("[data-sort-datetime]").dataset.sortDatetime)
      
      const matchesSearch = movieTitle.includes(searchTerm)
      const matchesDate = this.dateFilterMatches(showDate, dateFilter)
      
      row.style.display = matchesSearch && matchesDate ? "" : "none"
    })
  }
  
  dateFilterMatches(date, filter) {
    if (!filter) return true
    const today = new Date()
    
    switch(filter) {
      case 'today':
        return date.toDateString() === today.toDateString()
      case 'week':
        const weekAgo = new Date(today - 7 * 24 * 60 * 60 * 1000)
        return date >= weekAgo
      case 'month':
        return date.getMonth() === today.getMonth() && 
               date.getFullYear() === today.getFullYear()
      default:
        return true
    }
  }
}