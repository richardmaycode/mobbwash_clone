import { Controller } from "@hotwired/stimulus"
import { post } from "@rails/request.js"

// Connects to data-controller="push"
export default class extends Controller {
  static values = { subscriptionsUrl: { type: String, default: "http://localhost:3000/push_subscriptions" } }
  
  connect() {

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
