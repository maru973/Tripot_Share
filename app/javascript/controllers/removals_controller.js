import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="removals"
export default class extends Controller {
  connect() {
    this.startRemovalTimer()
  }

  startRemovalTimer() {
    setTimeout(() => {
      this.remove()
    }, 5000) // 5秒後にメッセージを削除
  }

  remove() {
    this.element.remove()
  }
}
