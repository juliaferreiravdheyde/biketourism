import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pin"
export default class extends Controller {
  static targets = ["pinImage"];
  connect() {
    this.element.addEventListener("ajax:success", this.handleSuccess);
  }

  disconnect() {
    this.element.removeEventListener("ajax:success", this.handleSuccess);
  }

  handleSuccess = (event) => {
    const [data, _status, _xhr] = event.detail;
    this.pinImageTarget.src = data.image_url;
  };
}
