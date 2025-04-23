import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['players', 'select']

  connect() {
    this.showSelectedPlayers({ target: this.selectTarget });
  }

  showSelectedPlayers({ target }) {
    var html = '';
    Array.from(target.selectedOptions).forEach((option) => {
      html += `${option.text}<br />`
    });
    this.playersTarget.innerHTML = html;
  }
}
