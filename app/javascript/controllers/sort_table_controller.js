import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="sort-table"
export default class extends Controller {
  static targets = ["header", "row"];

  connect() {
    this.sortDirection = 'asc';
  }

  sort(event) {
    const columnIndex = event.target.cellIndex; // Get column index
    const rows = Array.from(this.rowTargets); // Convert rows to array
    const sortedRows = this.sortRows(rows, columnIndex);

    this.sortDirection = this.sortDirection === 'asc' ? 'desc' : 'asc';

    // Reorder the rows in the DOM
    this.clearTable();
    sortedRows.forEach(row => {
      this.element.appendChild(row); // Append each row back to the table body
    });
  }

  sortRows(rows, columnIndex) {
    return rows.sort((a, b) => {
      const aText = a.cells[columnIndex].innerText.trim();
      const bText = b.cells[columnIndex].innerText.trim();

      const isNumeric = !isNaN(aText) && !isNaN(bText); // Check if values are numeric

      let comparison = 0;
      if (isNumeric) {
        comparison = parseFloat(aText) - parseFloat(bText);
      } else {
        comparison = aText.localeCompare(bText);
      }

      return this.sortDirection === 'asc' ? comparison : -comparison;
    });
  }

  clearTable() {
    // Clear all existing rows in the table
    this.rowTargets.forEach(row => row.remove());
  }
}
