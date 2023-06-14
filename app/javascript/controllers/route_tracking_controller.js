import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="route-tracking"
export default class extends Controller {
  static targets = ['position', 'status', 'startstop', 'save', 'discard', 'tracker', 'registerform', 'recordgif', 'map']
  static values = { id: Number }

  connect() {
    console.log("Tracker connected")
  }

  showForm() {
    this.trackerTarget.classList.add("d-none");
    this.registerformTarget.classList.remove("d-none");
  }

  trackRoute() {
    // e.preventDefault()
    if (!this.startstopTarget.classList.contains("started")) {
      this.intervalID = window.setInterval(this.getCoords.bind(this), 10000);
      this.startstopTarget.classList.remove("stopped");
      this.startstopTarget.classList.add("started");
      this.saveTarget.classList.add("d-none");
      this.discardTarget.classList.add("d-none");
      this.recordgifTarget.classList.remove("d-none");
      this.mapTarget.classList.add("d-none");
      this.statusTarget.textContent = "Recording route..."
      this.startstopTarget.innerHTML = '<i class="fa-solid fa-stop" style="font-size: 50px;"></i>';
      document.querySelector('.footer').classList.add('d-none');
    } else {
      clearInterval(this.intervalID);
      this.startstopTarget.classList.remove("started");
      this.startstopTarget.classList.add("stopped");
      this.saveTarget.classList.remove("d-none");
      this.discardTarget.classList.remove("d-none");
      this.recordgifTarget.classList.add("d-none");
      this.mapTarget.classList.add("d-none");
      this.statusTarget.textContent = "Recording paused"
      this.startstopTarget.textContent = "Continue Tracking";
      this.loadMarkers()
    }
  }

  loadMarkers() {
    fetch( `/routes/${this.idValue}/record`, {headers: {"Accept": "text/plain"}} )
      .then((response) => response.text())
      .then((data) => {
        console.log("Rendering map")
        this.mapTarget.outerHTML = data
      })
      .catch(error => {
        console.error("Error:", error);
      });
  }

  getCoords() {
    if (!navigator.geolocation) {
      this.statusTarget.textContent = "Geolocation is not supported by your browser";
    } else {
      this.statusTarget.textContent = "Recording route…";
      navigator.geolocation.getCurrentPosition(this.success.bind(this), this.error.bind(this));
    }
  }

  success(position) {
    const latitude = position.coords.latitude;
    const longitude = position.coords.longitude;

    // mapLink.href = `https://www.openstreetmap.org/#map=18/${latitude}/${longitude}`;
    this.positionTarget.textContent = `Latitude: ${latitude} °, Longitude: ${longitude} °`
    this.createPoint(latitude, longitude);
  }

  error() {
    this.statusTarget.textContent = "Unable to retrieve your location";
  }

  createPoint(latitude, longitude) {
    console.log("Creating Point");
    const token = document.getElementsByName('csrf-token')[0].content
    const url = `/routes/${this.idValue}/points?latitude=${latitude}&longitude=${longitude}`
    fetch(url, {
      method: 'POST',
      headers: {"Accept": "application/json", "X-CSRF-Token": token}})
      // .then(response => response.json())
      // .then((data) => {
      //   console.log(data)
      // })
  }
}
