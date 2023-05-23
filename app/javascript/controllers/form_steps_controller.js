import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="form-steps"
export default class extends Controller {
  static targets = ["step"];

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
}
