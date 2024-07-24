import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  connect() {
  }

  fetch() {
    clearTimeout(this.clearTimeout)
    this.timeout = setTimeout(() => {
      this.element.requestSubmit()
    }, 500)
  }
}
