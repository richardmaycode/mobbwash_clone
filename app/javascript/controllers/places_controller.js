import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="places"
export default class extends Controller {
  static targets = [ "field", "map", "latitude", "longitude" ]

  connect() {
    if (typeof(google) != "undefined") {
      this.initMap()
    }

    console.log("Places!")
  }

  async initMap() {
    this.map = new google.maps.Map(this.mapTarget, {
      center: new google.maps.LatLng(this.data.get("latitude") || 26.12, this.data.get("longitude") || -80.14),
      zoom: 13,// (this.data.get("latitude") == null ? 4 : 8)
      streetViewControl: false,
      mapTypeControlOptions: {
        mapTypeIds: ['roadmap']
     },
    })

    this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
    this.autocomplete.bindTo('bounds', this.map)
    this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name', 'utc_offset_minutes'])
    this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))

    this.marker = new google.maps.Marker({
      map: this.map,
      anchorPoint: new google.maps.Point(0, -29)
    })
  }

  placeChanged() {
    let place = this.autocomplete.getPlace()

    if (!place.geometry) {
      window.alert(`No details available for input: ${place.name}`)
      return
    }

    if (place.geometry.viewport) {
      this.map.fitBounds(place.geometry.viewport)
    } else {
      this.map.setCenter(place.geometry.location)
      this.map.setZoom(13)
      this.map.streetViewControl(false)
    }

    this.marker.setPosition(place.geometry.location)
    this.marker.setVisible(true)

    this.latitudeTarget.value = place.geometry.location.lat()
    this.longitudeTarget.value = place.geometry.location.lng()
    console.log(place.utc_offset_minutes)
  }

  keydown(event) {
    if (event.key == "Enter") {
      event.preventDefault()
    }
  }
}
