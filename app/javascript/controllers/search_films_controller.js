import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-films"
export default class extends Controller {
  static targets = ["input", "form", "list"];
  connect() {
    console.log("Connected!");
  }

  update() {
    // query the user is searching for...
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`;
    fetch(url, { headers: { Accept: "text/plain" } })
      .then((response) => response.text())
      .then((data) => {
        this.listTarget.innerHTML = data;
        // we want to replace the list with the new partial (aka the 'data')
      });
  }
}
