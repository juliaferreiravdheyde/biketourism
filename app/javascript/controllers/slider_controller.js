import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="slider"
export default class extends Controller {
  static targets = ['minvalue', 'maxvalue', 'minslider', 'maxslider', 'range']

  connect() {
    console.log("slider connected")
  }

  changeRange(e) {
    console.log('In Range Change')
    const rangeMin = 100;
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
      this.rangeTarget.style.left = (minRange / this.minsliderTarget.max) * 100 + "%";
      this.rangeTarget.style.right = 100 - (maxRange / this.maxsliderTarget.max) * 100 + "%";
    }
  }

  changeValue(e) {
    console.log('In Input Change')
    const rangeMin = 100;
    let minPrice = parseInt(this.minvalueTarget.value);
    let maxPrice = parseInt(this.maxvalueTarget.value);

    if (maxPrice - minPrice >= rangeMin && maxPrice <= this.maxsliderTarget.max) {
      if (e.target.name === "min") {
        this.minsliderTarget.value = minPrice;
        console.log('minslide edit');
        this.rangeTarget.style.left = (minPrice / this.minsliderTarget.max) * 100 + "%";
      } else {
        this.maxsliderTarget.value = maxPrice;
        console.log('maxslide edit');
        this.rangeTarget.style.right = 100 - (maxPrice / this.maxsliderTarget.max) * 100 + "%";
      }
    }
  }
}
