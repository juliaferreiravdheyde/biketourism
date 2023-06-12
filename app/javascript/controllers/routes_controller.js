import { Controller } from "stimulus";
import mapboxgl from "mapbox-gl";

export default class extends Controller {
  static targets = ["cityInput", "map"];

  connect() {
    mapboxgl.accessToken = process.env.MAPBOX_API_KEY;
    this.initMap();
  }

  async searchRoutes() {
    const cityInput = this.cityInputTarget;
    const city = cityInput.value;

    const response = await fetch(`/routes/search?city=${city}`);
    const routes = await response.json();

    this.clearMarkers();

    routes.forEach(route => {
      const marker = new mapboxgl.Marker()
        .setLngLat([route.points_longitude, route.points_latitude])
        .addTo(this.map);
      marker.setPopup(new mapboxgl.Popup().setHTML(route.name));
    });
  }

  clearMarkers() {
    const markers = document.getElementsByClassName("mapboxgl-marker");
    while (markers[0]) {
      markers[0].parentNode.removeChild(markers[0]);
    }
  }

  initMap() {
    const initialCoordinates = [-23.5505, -46.6333];
    const initialZoom = 12;

    this.mapTarget.innerHTML = ''; // Limpar o conteúdo do elemento do contêiner do mapa

    this.map = new mapboxgl.Map({
      container: this.mapTarget,
      style: "mapbox://styles/mapbox/streets-v10",
      center: initialCoordinates,
      zoom: initialZoom
    });

    this.map.addControl(new mapboxgl.NavigationControl());

    const form = this.element.querySelector("form");
    form.addEventListener("submit", event => {
      event.preventDefault();
      this.searchRoutes();
    });
  }
}
