#' Toggle UI in the Framework 7 structure
#'
#' @description A UI-side declaration of the toggle UI used for selecting
#' numbers or strings
#'
#' @param id The id used to reference the toggle object
#' @importFrom shiny NS
#' @export

toggle_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("toggle-ui"))
}


#' Toggle declaration for the server-side function
#'
#' @description THe server-side function for the toggle that is established as a
#' `shinyMobile` application
#'
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param label_ The title of the toggle object
#' @param checked The minimum set for the toggle
#' @param color_ The maximum set for the toggle
#'
#' @return [reactive] `logical`: `TRUE` or `FALSE`
#' @export

toggle_server <-
  function(input,
           output,
           session,
           label_ = "?",
           checked = TRUE,
           color_ = "blue") {
    session$ns -> ns

    label_ <- to_reactive(label_)
    checked <- to_reactive(checked)
    color_ <- to_reactive(color_)

    output[['toggle-ui']] <- renderUI({
      f7Toggle(
        inputId = ns("toggle"),
        label = label_(),
        checked = checked(),
        color = color_()
      )
    })

    return(list(value = reactive(input[['toggle']])))

  }
