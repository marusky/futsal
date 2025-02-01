import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="tab"
export default class extends Controller {
  static targets = ["indicator", "tab", "tabone", "tabtwo"]

  connect() {
    this.setActiveTab(this.tabTargets[0]) // Default active tab
  }

  switch(event) {
    event.preventDefault()

    // Find clicked tab
    const tab = event.currentTarget

    // Move the indicator
    this.indicatorTarget.style.transform = `translateX(${tab.offsetLeft}px)`
    this.indicatorTarget.style.width = `${tab.offsetWidth-5}px`

    // Update active styles
    this.tabTargets.forEach(t => t.classList.remove("bg-zinc-700", "shadow"))
    tab.classList.add("bg-zinc-700", "shadow")

    // Move content
    if (tab === this.tabTargets[1]) {
      this.taboneTarget.classList.add("-translate-x-[105%]")
      this.tabtwoTarget.classList.remove("translate-x-[105%]")
    } else {
      this.taboneTarget.classList.remove("-translate-x-[105%]")
      this.tabtwoTarget.classList.add("translate-x-[105%]")
    }
  }

  setActiveTab(tab) {
    this.switch({ preventDefault: () => {}, currentTarget: tab })
  }
}