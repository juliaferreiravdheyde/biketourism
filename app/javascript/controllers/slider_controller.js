import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ['minvalue', 'maxvalue', 'minslider', 'maxslider', 'range']

  connect() {
    console.log("slider connected")
  }

  changeRange(e) {
    console.log('In Range Change')
    let rangeMin = 100;
    let minRange = parseInt(this.minsliderTarget.value);
    let maxRange = parseInt(this.maxsliderTarget.value);

    if (maxRange - minRange < rangeMin) {
      if (e.target.className === "min") {
        this.minsliderTarget.value = maxRange - rangeMin;
      } else {
        this.maxsliderTarget.value = minRange + rangeMin;
      }
    } else {
      this.minvalueTarget.value = minRange;
      this.maxvalueTarget.value = maxRange;
      console.log(this.rangeTarget);
      console.log(this.rangeTarget.style);
      console.log(this.rangeTarget.style.left);
      console.log((minRange / this.minsliderTarget.max) * 100 + "%");
      this.rangeTarget.style.left = (minRange / this.minsliderTarget.max) * 100 + "%";
      this.rangeTarget.style.right = 100 - (maxRange / this.maxsliderTarget.max) * 100 + "%";
    }
  }
}
