// app/javascript/controllers/test_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["optionsContainer", "select"]

  connect() {
    if (this.selectTarget.value) {
      this.changeType()
    }
  }

  async changeType() {
    const questionType = this.selectTarget.value
    const response = await fetch(`/test_sets/question_options/${questionType}`)
    const html = await response.text()
    this.optionsContainerTarget.innerHTML = html
  }

  // Add unique event handlers for each question type
  handleMultipleChoice() {
    // Logic for multiple choice
  }

  handleMultipleSelection() {
    // Logic for multiple selection
  }

  handleFillInBlank() {
    // Logic for fill in blank
  }

  handleMatching() {
    // Logic for matching
  }
}

