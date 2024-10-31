import "@hotwired/turbo-rails"
import "controllers"
import { Application } from "@hotwired/stimulus"
import { definitionsFromContext } from "@hotwired/stimulus-loading"
console.log("Application loaded!")

// Connect Stimulus to the application

const application = Application.start()
const context = require.context("./controllers", true, /\.js$/)
application.load(definitionsFromContext(context))

export { application }