import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ['players']
  connect() {
    // console.log('helou')
    // console.log(this.playersTarget)
  }

  show_selected_players({ target }) {
    var html = '';
    Array.from(target.selectedOptions).forEach((option) => {
      html += `${option.text}<br />`
    });
    this.playersTarget.innerHTML = html;
  }
}
