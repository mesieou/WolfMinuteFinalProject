import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="copy"
export default class extends Controller {
static targets = ["text"]

  connect() {
  }

  copyToClipboard() {
    let text = ""
    this.textTargets.forEach((p) => {
      text = text + p.textContent + " "

    })

    navigator.clipboard.writeText(text)
  }
}
