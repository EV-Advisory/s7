#'
#' Framework 7 select
#'
#' @description The framework 7 select input that
#' relies on the shinyMobile package to develop
#' a compatible UI useful in PWAs
#'
#' @param id  the namespace id of the select UI
#'
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput


select_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("select"))
}


#' Framework 7 select server-side logic
#'
#'
#' @description The server-side function used in
#' shinyMobile developed shiny applications
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param label The label on the select UI
#' @param choices The choices available for the select UI
#' @param selected The option selected by default for the select UI
#' @param width Width of the select UI
#'
#' @export
#' @importFrom shinyMobile f7Select


select_server <-
  function(input,
           output,
           session,
           label,
           choices,
           selected = NULL,
           width = NULL) {

    label = hrimodules:::to_reactive(label)
    choices = hrimodules:::to_reactive(choices)
    selected = hrimodules:::to_reactive(selected)
    width = hrimodules:::to_reactive(width)

    output[['select']] <- renderUI({
      shinyMobile::f7Select(
        inputId = ns("select"),
        label = label(),
        choices = choices(),
        selected = selected(),
        width = width()
      )
    })

  }
