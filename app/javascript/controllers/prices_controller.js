import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"
// Connects to data-controller="prices"
export default class extends Controller {
  static values = { region: Number, fetchUrl: String }
  static targets = [ "display", "input", "zone" ]
  connect() {
    if (this.queryReady) {
      this.fetchPrice
    }
  }
  setService(event) {
    this.service = event.target.value
    console.log(this.service)
    
    if (event.target.value == 4) {
      this.zoneTarget.classList.add("hidden")
    }
    
    if (this.#readyForFetch()) {
      this.#fetchPrice()
    }
  }
  setSize(event) {
    this.size = event.target.value
    console.log(this.size)
    if (this.#readyForFetch()) {
      this.#fetchPrice()
    }
  }



  assignPrice() {
    const data = this.#fetchPrice()
  }

  #readyForFetch() {
    return this.service != null && this.size != null
  }

  async #fetchPrice() {
    const response = await get(this.fetchUrlValue, { query: { region_id: this.regionValue, vehicle_size_id: parseInt(this.size), service_id: parseInt(this.service) }, responseKind: "json" })
    response.json.then((json) => {
      this.displayTarget.innerHTML = (json.formatted_amount)
      this.inputTarget.value = (json.id)
      this.zoneTarget.classList.remove("hidden")
    })
  }
}
