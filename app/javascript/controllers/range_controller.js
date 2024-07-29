import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="range"
export default class extends Controller {
  static targets = ["slider", "output", "payout" ]
  static values = { prefix: { type: String, default: "" } }
  connect() {
    console.log(this.outputTarget)
    console.log(this.sliderTarget)
    this.recalculate()
  }

  recalculate() {
    console.log("I recalculated")
    console.log(parseFloat(this.sliderTarget.value).toFixed(2))
    this.outputTarget.innerHTML = this.prefixValue + parseFloat(this.sliderTarget.value).toFixed(2)
    this.payoutTarget.innerHTML = this.prefixValue + parseFloat(this.sliderTarget.value / 1.25).toFixed(2)
  }
}
