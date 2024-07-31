import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

// Connects to data-controller="push"
export default class extends Controller {

  static values = { subscriptionsUrl: { type: String, default: "http://localhost:3000/push_subscriptions" } }
  connect() {

    console.log("Hello from Push Controller")
    console.log(this.subscriptionsUrlValue)
    // attemptToSubscribe();

    // Check if the browser supports notifications
    // if ("Notification" in window) {
    //   // Request permission from the user to send notifications
    //   Notification.requestPermission().then((permission) => {
    //     if (permission === "granted") {
    //       // If permission is granted, register the service worker
    //       this.registerServiceWorker();
    //     } else if (permission === "denied") {
    //       console.warn("User rejected to allow notifications.");
    //     } else {
    //       console.warn("User still didn't give an answer about notifications.");
    //     }
    //   });
    // } else {
    //   console.warn("Push notifications not supported.");
    // }
  }

  async attemptToSubscribe() {
    if (this.#allowed) {
      const registration = await this.#serviceWorkerRegistration || await this.#registerServiceWorker()

      switch(Notification.permission) {
        case "denied":  { this.#revealNotAllowedNotice(); break }
        case "granted": { this.#subscribe(registration); break }
        case "default": { this.#requestPermissionAndSubscribe(registration) }
      }
    } else {
      this.#revealNotAllowedNotice()
    }
  }

  get #allowed() {
    return navigator.serviceWorker && window.Notification
  }

  #registerServiceWorker() {
    return navigator.serviceWorker.register("/service-worker.js")
  }

  get #serviceWorkerRegistration() {
    return navigator.serviceWorker.getRegistration("http://localhost:3000/")
  }

  #revealNotAllowedNotice() {
    this.notAllowedNoticeTarget.showModal()
  }

  // registerServiceWorker() {
  //   // Check if the browser supports service workers
  //   if ("serviceWorker" in navigator) {
  //     // Register the service worker script (service_worker.js)
  //     navigator.serviceWorker
  //       .register('/service-worker.js')
  //       .then((serviceWorkerRegistration) => {
  //         // Check if a subscription to push notifications already exists
  //         serviceWorkerRegistration.pushManager
  //           .getSubscription()
  //           .then((existingSubscription) => {
  //             if (!existingSubscription) {
  //               // If no subscription exists, subscribe to push notifications
  //               serviceWorkerRegistration.pushManager
  //                 .subscribe({
  //                   userVisibleOnly: true,
  //                   applicationServerKey: this.element.getAttribute(
  //                     "data-application-server-key"
  //                   ),
  //                 })
  //                 .then((subscription) => {
  //                   // Save the subscription on the server
  //                   this.saveSubscription(subscription);
  //                 });
  //             }
  //           });
  //       })
  //       .catch((error) => {
  //         console.error("Error during registration Service Worker:", error);
  //       });
  //   }
  // }

  // saveSubscription(subscription) {
  //   // Extract necessary subscription data
  //   const endpoint = subscription.endpoint;
  //   const p256dh = btoa(
  //     String.fromCharCode.apply(
  //       null,
  //       new Uint8Array(subscription.getKey("p256dh"))
  //     )
  //   );
  //   const auth = btoa(
  //     String.fromCharCode.apply(
  //       null,
  //       new Uint8Array(subscription.getKey("auth"))
  //     )
  //   );

  //   console.log(p256dh)

  //   // Send the subscription data to the server
  //   fetch("/push_subscriptions", {
  //     method: "POST",
  //     headers: {
  //       "Content-Type": "application/json",
  //       Accept: "application/json",
  //       "X-CSRF-Token": document
  //         .querySelector('meta[name="csrf-token"]')
  //         .getAttribute("content"),
  //     },
  //     body: this.#extractJsonPayloadAsString(subscription)
  //   })
  //     .then((response) => {
  //       if (response.ok) {
  //         console.log("Subscription successfully saved on the server.");
  //       } else {
  //         console.error("Error saving subscription on the server.");
  //       }
  //     })
  //     .catch((error) => {
  //       console.error("Error sending subscription to the server:", error);
  //     });
  // }

  #extractJsonPayloadAsString(subscription) {
    const { endpoint, keys: { p256dh, auth } } = subscription.toJSON()

    return JSON.stringify({ push_subscription: { endpoint, p256dh_key: p256dh, auth_key: auth } })
  }

  async #requestPermissionAndSubscribe(registration) {
    const permission = await Notification.requestPermission()
    if (permission === "granted") this.#subscribe(registration)
  }

  async #subscribe(registration) {
    registration.pushManager
      .subscribe({ userVisibleOnly: true, applicationServerKey: this.#vapidPublicKey })
      .then(subscription => {
        this.#syncPushSubscription(subscription)
        this.dispatch("ready")
      })
  }

  get #vapidPublicKey() {
    const encodedVapidPublicKey = document.querySelector('meta[name="vapid-public-key"]').content
    return this.#urlBase64ToUint8Array(encodedVapidPublicKey)
  }

  // VAPID public key comes encoded as base64 but service worker registration needs it as a Uint8Array
  #urlBase64ToUint8Array(base64String) {
    const padding = "=".repeat((4 - base64String.length % 4) % 4)
    const base64 = (base64String + padding).replace(/-/g, "+").replace(/_/g, "/")

    const rawData = window.atob(base64)
    const outputArray = new Uint8Array(rawData.length)

    for (let i = 0; i < rawData.length; ++i) {
      outputArray[i] = rawData.charCodeAt(i)
    }

    return outputArray
  }

  async #syncPushSubscription(subscription) {
    console.log(this.subscriptionsUrlValue)

    const response = await post(this.subscriptionsUrlValue, { body: this.#extractJsonPayloadAsString(subscription), responseKind: "turbo-stream" })
    console.log(response)
    if (!response.ok) subscription.unsubscribe()
  }
}
