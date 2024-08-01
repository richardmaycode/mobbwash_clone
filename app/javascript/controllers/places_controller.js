import { Controller } from "@hotwired/stimulus"
import { Loader } from "@googlemaps/js-api-loader"

// Connects to data-controller="places"
export default class extends Controller {
  static values = { key: String }
  static targets = [ "field", "map", "latitude", "longitude" ]

  connect() {
    const loader = new Loader({
      apiKey: this.keyValue,
      version: "quarterly",
      libraries: ["maps","places", "marker"]
    })

    loader
      .load()
      .then((google) => {
        // create map at user defined location or defaults
        this.map = new google.maps.Map(this.mapTarget, {
          center: new google.maps.LatLng(this.latitudeTarget.value || 26.12, this.longitudeTarget.value || -80.14),
          zoom: 13,
          streetViewControl: false,
          mapTypeControlOptions: {
            mapTypeIds: ['roadmap']
         },
        })
        
        // init autocomplete
        this.autocomplete = new google.maps.places.Autocomplete(this.fieldTarget)
        this.autocomplete.bindTo('bounds', this.map)
        this.autocomplete.setFields(['address_components', 'geometry', 'icon', 'name', 'utc_offset_minutes'])
        this.autocomplete.addListener('place_changed', this.placeChanged.bind(this))
    
        // init marker for user defined location or defaults
        this.marker = new google.maps.Marker({
          map: this.map,
          anchorPoint: new google.maps.Point(this.latitudeTarget.value || 0, this.longitudeTarget.value || -29)
        })

      })
      .catch((e) => {
        console.log("error loading gmaps")
        console.log(e)
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
