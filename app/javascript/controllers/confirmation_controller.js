// app/javascript/controllers/confirmation_controller.js

// Creates a pop up to stop a action from occuring.
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]
  
  connect() {
    this.modal = new bootstrap.Modal(this.modalTarget)
  }

  show(event) {
    event.preventDefault()
    this.modal.show()
  }

  confirm(event) {
    this.modal.hide()
  }

  hide(event) {
    this.modal.hide()
  }
}