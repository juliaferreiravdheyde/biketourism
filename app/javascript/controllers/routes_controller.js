import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["cityInput", "map"];

  connect() {
    this.initMap();
  }

  async searchRoutes() {
    const cityInput = this.cityInputTarget;
    const city = cityInput.value;

    const response = await fetch(`/routes/search?city=${city}`);
    const routes = await response.json();

    // Agora você pode fazer o que quiser com as rotas
    // Por exemplo, adicionar marcadores no mapa

    // Exemplo básico de adicionar marcadores usando a biblioteca Leaflet
    routes.forEach(route => {
      const marker = L.marker([route.latitude, route.longitude]).addTo(this.map);
      marker.bindPopup(route.name);
    });
  }

  initMap() {
    const initialCoordinates = [-23.5505, -46.6333]; // Exemplo de coordenadas para São Paulo, Brasil
    const initialZoom = 12; // Exemplo de nível de zoom inicial

    this.map = L.map(this.mapTarget).setView(initialCoordinates, initialZoom);

    L.tileLayer("https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png", {
      attribution: 'Map data &copy; <a href="https://www.openstreetmap.org/">OpenStreetMap</a> contributors',
      maxZoom: 18,
    }).addTo(this.map);
  }

}
