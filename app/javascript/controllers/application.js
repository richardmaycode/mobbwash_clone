import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

// window.initMap = function (...args) {
//   const event = new Event('google-maps-callback', { bubbles: true, cancelable: true });
//   event.args = args;
//   document.dispatchEvent(event);
// };
