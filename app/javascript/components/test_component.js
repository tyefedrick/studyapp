// app/javascript/components/test_component.js
import React from 'react'

const TestComponent = () => {
  console.log('TestComponent is being rendered')
  return React.createElement('div', {
    style: {
      padding: '20px',
      backgroundColor: 'lightblue',
      border: '2px solid blue',
      margin: '10px'
    }
  }, 'React is Working! The time is: ' + new Date().toLocaleTimeString())
}

export default TestComponent

// <!-- Add this before your existing content -->
// <div id="react-root"></div>