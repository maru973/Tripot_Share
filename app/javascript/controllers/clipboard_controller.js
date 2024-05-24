import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="clipboard"
export default class extends Controller {
  static targets = ['link']

  copyToClipboard(event) {
    event.preventDefault();
    navigator.clipboard.writeText(this.linkTarget.textContent)
      .then(() => {
        alert("招待リンクをコピーしました");
      })
      .catch(err => {
        alert("招待リンクのコピーに失敗しました");
      });
  }
}
