import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  static targets = ["slider", "output" ]
  connect() {
    console.log(this.outputTarget)
    console.log(this.sliderTarget)
    this.recalculate()
  }

  recalculate() {
    console.log("I recalculated")
    this.outputTarget.innerHTML = this.sliderTarget.value
  }
}
