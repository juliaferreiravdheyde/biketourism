import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    mapboxgl.accessToken = this.apiKeyValue

    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })
    this.#addMarkersToMap()
    this.#fitMapToMarkers()

    this.map.on("load", () => {
      this.addRouteLayer()
    })
  }

  addRouteLayer() {
    this.map.addSource("route", {
      type: "geojson",
      data: {
        type: "Feature",
        properties: {},
        geometry: {
          type: "LineString",
          coordinates: this.markersValue.map(marker => [ marker.lng, marker.lat ] )
        }
      }
    })

    this.map.addLayer({
      id: "route",
      type: "line",
      source: "route",
      layout: {
        "line-join": "round",
        "line-cap": "round"
      },
      paint: {
        "line-color": "#888",
        "line-width": 8
      }
    })
  }

  #addMarkersToMap() {
    const startMarker = this.markersValue[0]
    const stopMarker = this.markersValue[this.markersValue.length - 1]
    new mapboxgl.Marker()
      .setLngLat([ startMarker.lng, startMarker.lat ])
      .addTo(this.map)
    new mapboxgl.Marker()
      .setLngLat([ stopMarker.lng, stopMarker.lat ])
      .addTo(this.map)
  }

  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.map.fitBounds(bounds, { padding: 90, maxZoom: 15, duration: 0 })
  }

}
