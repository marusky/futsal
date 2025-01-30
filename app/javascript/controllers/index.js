// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application"
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading"
import AutoSubmit from 'controllers/auto_submit_controller'

eagerLoadControllersFrom("controllers", application)
application.register('auto-submit', AutoSubmit)