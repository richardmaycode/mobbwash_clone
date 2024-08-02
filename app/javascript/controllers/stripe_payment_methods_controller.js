import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stripe-payment-methods"
export default class extends Controller {
  static values = { publicKey: String, clientSecret: String }
  static targets = [ "payment", "method" ]
  
  async connect() {
    this.stripe = Stripe(this.publicKeyValue)



    
    // this.elements = this.stripe.elements();
    // this.cardElement = this.elements.create('card');

    
    // this.cardElement.mount(this.methodTarget);
    
  }

  disconnect() {
    // this.checkout.destroy
  }

  async submit() {
    this.elements.submit().then(function(result) {
      console.log(result)
    })
  }
}
