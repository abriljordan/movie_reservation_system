// Import and register all your controllers from the importmap via controllers/**/*_controller


import { application } from "./application"
import SeatSelectionController from "./seat_selection_controller"

application.register("seat-selection", SeatSelectionController)
