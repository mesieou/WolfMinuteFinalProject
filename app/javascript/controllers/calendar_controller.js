
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["month", "week"]

  connect() {
    console.log("Hello from our first Stimulus controller")
    console.log(this.weekTarget.style)
  }

  weekly() {
   this.monthTarget.classList.add("hidden")
   this.weekTarget.classList.remove("hidden")
  }

  monthly() {
    this.monthTarget.classList.remove("hidden")
   this.weekTarget.classList.add("hidden")
  }


}
