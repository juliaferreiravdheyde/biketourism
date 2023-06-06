import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="route-tracking"
export default class extends Controller {
  connect() {
    console.log("Teste")
  }
}
