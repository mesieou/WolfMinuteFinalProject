import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-steps"
export default class extends Controller {
  static targets = ["step", "description", "startTime", "location", "duration", "gptResult"];

  connect() {
    this.currentStep = 0;
    this.showCurrentStep();
  }

  nextStep() {
    this.currentStep++;
    this.showCurrentStep();
  }

  showCurrentStep() {
    this.stepTargets.forEach((step, index) => {
      if (index === this.currentStep) {
        step.classList.remove('hidden');
      }
    });
  }

  fetchResultsFromForm() {
    const url = `/meetings/new?description=${this.descriptionTarget.value}&startTime=${this.startTimeTarget.value}&location=${this.locationTarget.value}&duration=${this.durationTarget.value}`;
    fetch(url, { headers: { "Accept": "text/plain", method: "get" } })
      .then((response) => response.text())
      .then((data) => {
        this.gptResultTarget.innerHTML = data;
        console.log(data)

      })
      .catch((error) => {
        console.error(error)});
  }
}
