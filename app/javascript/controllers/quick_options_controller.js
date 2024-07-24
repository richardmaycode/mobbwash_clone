import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="quick-options"
export default class extends Controller {
  static targets = [ "output" ]

  fill(event) {
    event.preventDefault();
    this.outputTarget.value = event.currentTarget.dataset.value
  }
}
