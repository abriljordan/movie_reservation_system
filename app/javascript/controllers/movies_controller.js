import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  remove(event) {
    const movieCard = event.target.closest(".movie-card")
    movieCard.addEventListener("turbo:before-stream-render", () => {
      movieCard.style.opacity = 0
    })
  }
}
