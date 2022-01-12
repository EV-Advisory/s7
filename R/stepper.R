#'
#' Framework 7 stepper
#'
#' @description The framework 7 stepper input that
#' relies on the shinyMobile package to develop
#' a compatible UI useful in PWAs
#'
#' @param id  the namespace id of the stepper UI
#'
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput
#'@export

stepper_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("stepper"))
}


#TO DO: ADD as parameters
# label = NULL,
# min = 0,
# max = 10,
# step = 1,
# fill = F,
# rounded = F,
# raised = F,
# size = NULL,
# color = NULL,
# wraps = F,
# autorepeat = T,
# manual = F,
# decimalPoint = 4,
# buttonsEndInputMode = T
#' Framework 7 stepper server-side logic
#'
#'
#' @description The server-side function used in
#' shinyMobile developed shiny applications
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param label The label on the stepper UI
#' @param min_ The minimum value of the stepper UI
#' @param max_ The maximum value of the stepper UI
#' @param value_ The value selected of the stepper UI
#' @param ... additional parameters passed to the \code{f7Stepper()} function
#'
#' @export
#' @importFrom shinyMobile f7Stepper



stepper_server <-
  function(input,
           output,
           session,
           label = shiny::h4("Weeks"),
           min_ = 1,
           max_ = 26,
           value_ = 3,
           ...) {
    # Session Namespace
    session$ns -> ns

    output[['stepper']] <- renderUI({
      f7Stepper(
        ns("stepper"),
        label = label,
        min = min_,
        max = max_,
        value = value_,
        ...
      )
    })

    return(list(step = reactive(input[['stepper']])))

  }
