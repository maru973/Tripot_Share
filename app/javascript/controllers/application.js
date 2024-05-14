import { Application } from "@hotwired/stimulus"

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }

import { Modal, Tabs } from "tailwindcss-stimulus-components"
application.register('modal', Modal)
application.register('tabs', Tabs)