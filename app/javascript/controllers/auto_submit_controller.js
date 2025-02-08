import AutoSubmit from "@stimulus-components/auto-submit"

export default class extends AutoSubmit {
  static values = {
    delay: {
      type: Number,
      default: 3000,
    },
  }

  select({ target }) {
    target.select()
  }
}