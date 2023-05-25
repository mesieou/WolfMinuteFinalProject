import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-steps"
export default class extends Controller {
  static targets = ["step", "description", "startTime", "location", "duration", "gptResult", "checkbox", "availabletime", "endTime", "gptTimeResult"];

  connect() {
    this.currentStep = 0;
    this.showCurrentStep();
  }

  nextStep() {
    this.currentStep++;
    this.showCurrentStep();
  }
  nextStep2(event) {
    let users_names = []
    this.checkboxTargets.forEach((checkbox) => {
      if (checkbox.checked) {
        users_names.push(checkbox.value)
        this.fetchNextAvailableTime(users_names)
      }
    });
    this.currentStep++;
    this.showCurrentStep();
  }

  fetchNextAvailableTime(users_names) {
    const url = `/meetings/new?usersnames=${users_names}`
    fetch(url, { headers: { "Accept": "text/plain", method: "get" } })
      .then((response) => response.text())
      .then((data) => {
        this.availabletimeTarget.innerHTML = data;
      })
      .catch((error) => {
        console.error(error)});
  }

  showCurrentStep() {
    this.stepTargets.forEach((step, index) => {
      if (index === this.currentStep) {
        step.classList.remove('hidden');
      }
    });
  }

  fetchResultsFromForm() {
    const url = `/meetings/new?description=${this.descriptionTarget.value}&startTime=${this.startTimeTarget.value}&location=${this.locationTarget.value}&endTime=${this.endTimeTarget.value}`;
    fetch(url, { headers: { "Accept": "text/plain", method: "get" } })
      .then((response) => response.text())
      .then((data) => {
        this.gptResultTarget.innerHTML = data;
        console.log(data)

      })
      .catch((error) => {
        console.error(error)});
  }
  fetchDuration(users_names) {
    const url = `/meetings/new?description=${this.descriptionTarget.value}&usersnames=${users_names}`;
    fetch(url, { headers: { "Accept": "text/plain", method: "get" } })
      .then((response) => response.text())
      .then((data) => {
        this.gptTimeResultTarget.innerHTML = data;
        console.log(typeof data, data,  this.gptTimeResultTarget)

      })
      .catch((error) => {
        console.error(error)});
  }
}
