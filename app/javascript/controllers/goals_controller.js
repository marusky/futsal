import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="goals"
export default class extends Controller {
  static targets = ['goals']

  minus() {
    const goals = parseInt(this.goalsTarget.value)
    if (goals > 0) {
      this.goalsTarget.value = parseInt(this.goalsTarget.value) - 1;
    }
    this.dispatchEvent()
  }
  
  plus() {
    this.goalsTarget.value = parseInt(this.goalsTarget.value) + 1;
    this.dispatchEvent()
  }
  
  dispatchEvent() {
    this.goalsTarget.dispatchEvent(new Event("input", { bubbles: true }))
  }
}
