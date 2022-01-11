#' Slider UI in the Framework 7 structure
#'
#' @description A UI-side declaration of the slider UI used for selecting
#' numbers or strings
#'
#' @param id The id used to reference the slider object
#' @importFrom shiny NS
#' @export
slider_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("slider"))
}


#' Slider declaration for the server-side function
#'
#' @description THe server-side function for the slider that is established a
#' `shinyMobile` application
#'
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param label_ The title of the slider object
#' @param min_ The minimum set for the slider
#' @param max_ The maximum set for the slider
#' @param value_ The default value set for the UI
#' @param ... Additional fields to be passed into the \code{shinyMobile::f7Slider()}
#' @export

slider_server <- function(input,
                          output,
                          session,
                          label_ = shiny::h4("Weeks"),
                          min_ = 1,
                          max_ = 26,
                          value_ = 3,
                          ...) {
  session$ns->ns
  output[['slider']] <- renderUI({
    f7Slider(
      inputId = ns("slider"),
      label = label_,
      min = min_,
      max = max_,
      value = value_,
      ...
    )
  })

  return(list(value = reactive(input[['slider']])))

}
