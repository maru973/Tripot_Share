import { Controller } from "@hotwired/stimulus"
import Sortable from "sortablejs"

// Connects to data-controller="sortable"
export default class extends Controller {
  static values = {
    handleSelector: String,
  }
  connect() {
    const options = {
      onEnd: this.onEnd.bind(this),
      ghostClass: "bg-gray-300",
    }
    if (this.hasHandleSelectorValue) {
      options.handle = this.handleSelectorValue
    }
    Sortable.create(this.element, options)
  }
 
  onEnd(evt) {
    const body = { row_order_position: evt.newIndex }
    console.log(body)
  }
}
