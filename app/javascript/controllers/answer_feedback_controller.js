// /Users/tylerfedrick/studyapp/app/javascript/controllers/answer_feedback_controller.js
import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["explanation"]

  connect() {
    this.handleFlashMessage()
  }

  handleFlashMessage() {
    const flash = document.querySelector('.flash')
    if (!flash) return

    const isCorrect = flash.classList.contains('flash-success')
    const selectedAnswers = this.element.querySelectorAll('input:checked')
    
    selectedAnswers.forEach(input => {
      const answerDiv = input.closest('.form-check')
      if (isCorrect) {
        answerDiv.classList.add('bg-success', 'text-white')
        this.showExplanation()
      } else {
        answerDiv.classList.add('bg-danger', 'text-white')
        this.showCorrectAnswer()
        this.showExplanation()
      }
    })
  }

  showCorrectAnswer() {
    const correctAnswers = this.element.querySelectorAll('.form-check[data-correct="true"]')
    correctAnswers.forEach(answer => {
      answer.classList.add('bg-success', 'text-white')
    })
  }

  showExplanation() {
    if (this.hasExplanationTarget) {
      this.explanationTarget.classList.remove('d-none')
    }
  }
}