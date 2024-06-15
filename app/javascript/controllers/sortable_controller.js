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
    const body = { 
      row_order_position: evt.newIndex,
      spot_id: evt.item.dataset.spotId
    }
    console.log(body);
    fetch(evt.item.dataset.sortableUrl, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
      },
      body: JSON.stringify(body)
    })
    .then(response => {
      if (!response.ok) {
        throw new Error('ネットワークエラーです');
      }
    })
    .catch(error => {
      console.error('問題が起きてます:', error);
    });
    this.updateOrder();
  }

  // 順番を即時反映するメソッド
  updateOrder() {
    // コードからすべてのtrタグを取得
    const rows = this.element.querySelectorAll('tr');
    // 取得したtrタグの中からクラス名がorderのコードのみ取得
    const validRows = Array.from(rows).filter(row => row.querySelector('.order'));
    validRows.forEach((row, index) => {
      const orderCell = row.querySelector('.order');
      if (orderCell) {
        orderCell.textContent = String.fromCharCode(66 + index); // B, C, D, E, F, Gのみを使って設定
      }
    });
  }
}
