// app/javascript/application.js
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"
import "jquery"
import "cocoon"

import React from "react"
import * as ReactDOM from "react-dom"
import * as ReactDOMClient from "react-dom/client"

// Make React available globally
window.React = React
window.ReactDOM = ReactDOM
window.ReactDOMClient = ReactDOMClient

// Basic React setup with Turbo
document.addEventListener("turbo:load", () => {
  const reactRoot = document.getElementById('react-root')
  if (reactRoot && !reactRoot.dataset.reactMounted) {
    const root = ReactDOMClient.createRoot(reactRoot)
    root.render(React.createElement('div', null))
    reactRoot.dataset.reactMounted = 'true'
  }
})