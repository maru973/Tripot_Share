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
    this.updateOrder();
    const body = { 
      row_order_position: evt.newIndex,
      spot_id: evt.item.dataset.spotId
    }
    fetch(evt.item.dataset.sortableUrl, {
      method: 'PATCH',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Accept': 'text/vnd.turbo-stream.html'  // Turbo Streamのレスポンスを受け入れる
      },
      body: JSON.stringify(body)
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.text();  // Turbo StreamはHTMLとして返される
    })
    .then(turboStream => {
      const parser = new DOMParser();
      const doc = parser.parseFromString(turboStream, 'text/html');
      doc.body.querySelectorAll('turbo-stream').forEach(stream => {
        document.documentElement.appendChild(stream);
      });
    })
    .catch(error => {
      console.error('There has been a problem with your fetch operation:', error);
    });
  }

  // 順番を即時反映するメソッド
  updateOrder() {
    const rows = this.element.querySelectorAll('tr');
    const validRows = Array.from(rows).filter(row => row.querySelector('.order'));
    validRows.forEach((row, index) => {
      const orderCell = row.querySelector('.order');
      if (orderCell) {
        orderCell.textContent = String.fromCharCode(66 + index); // B, C, D, E, F, Gのみを使って設定
      }
    });
  }
}
