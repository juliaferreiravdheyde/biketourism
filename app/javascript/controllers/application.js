import { Application } from "@hotwired/stimulus"
import RoutesController from "../controllers/routes_controller"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

const application = Application.start()
application.register("routes", RoutesController)
