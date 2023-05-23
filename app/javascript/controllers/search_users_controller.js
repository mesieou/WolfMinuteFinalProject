import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-users"
export default class extends Controller {
  static targets = ["input", "form", "users", "users-clicked"]

  connect() {
  }

  search() {
    const url = `${this.formTarget.action}?query=${this.inputTarget.value}`
    fetch(url, { headers: {"Accept": "text/plain"}})
    .then(response => response.text())
    .then((data) => {
      console.log(typeof data);
      this.usersTarget.innerHTML = data
    })
  }
}
