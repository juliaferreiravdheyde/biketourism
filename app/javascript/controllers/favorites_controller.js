import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="favorites"
export default class extends Controller {
  static targets = ["heart"];
  connect() {
  }
  toggleFavorite(event) {
    event.preventDefault();
    const heart = this.heartTarget;
    const url = this.element.getAttribute("href");
    fetch(url, { method: "POST", headers: { "X-Requested-With": "XMLHttpRequest" } })
      .then((response) => response.text())
      .then((html) => {
        heart.innerHTML = html;
      });
  }
}
