import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="scheduling"
export default class extends Controller {
  static values = { asapDate: String }
  static targets = [ "hiddenInput", "shownInput" ]

  connect() {
    // Set default value for both targets
    this.hiddenInput = this.hiddenInputTarget
    this.shownInput = this.shownInputTarget
    this.hiddenInput.value = this.asapDateValue.slice(0,-6)
    this.shownInput.value = this.asapDateValue.slice(0,-6)
    this.shownInput.disabled = true
    
  }

  switchType(event) {
    if (event.target.value == "asap") {
      this.shownInput.classList.add("hidden")
      this.shownInput.disabled = true
      this.hiddenInput.disabled = false
    } else {
      this.shownInput.classList.remove("hidden")
      this.hiddenInput.disabled = true
      this.shownInput.disabled = false
    }
  }
}
