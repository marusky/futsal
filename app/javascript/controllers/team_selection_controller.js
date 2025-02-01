import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="team-selection"
export default class extends Controller {
  static targets = ["checkbox", "label", "indicator"]

  toggle(event) {
    event.preventDefault()

    const checkbox = this.checkboxTarget
    checkbox.checked = !checkbox.checked

    this.labelTarget.classList.toggle("bg-zinc-800", checkbox.checked)
    this.labelTarget.classList.toggle("text-zinc-500", !checkbox.checked)
    this.indicatorTarget.classList.toggle("bg-indigo-500", checkbox.checked)
  }
}
