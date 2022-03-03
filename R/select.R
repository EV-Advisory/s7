#'
#' Framework 7 select
#'
#' @description The framework 7 select input that
#' relies on the shinyMobile package to develop
#' a compatible UI useful in PWAs
#'
#' @param id  the namespace id of the select UI
#' @param ... additional parameters to uiOutput function
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput
#'@export

select_ui <- function(id, ...) {
  ns <- NS(id)
  uiOutput(ns("select-ui"), ...)
}


#' Framework 7 select server-side logic
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
#' @param req_ If a specific requirement is to be included, create a string of R code to evaluate the requirement (i.e. \code{req()})
#' @param ... additional parameters for f7Select
#'
#' @export
#' @import magrittr
#' @importFrom shinyMobile f7Select


select_server <-
  function(input,
           output,
           session,
           label,
           choices,
           selected = NULL,
           width = NULL,
           req_ = NULL,
           ...) {
    session$ns -> ns
    label = to_reactive(label)
    choices = to_reactive(choices)
    selected = to_reactive(selected)
    width = to_reactive(width)

    output[['select-ui']] <- renderUI({
      if(!is.null(req_))req(eval(parse(paste0(req_))))
      shinyMobile::f7Select(
        inputId = ns("select"),
        label = label(),
        choices = choices(),
        selected = selected(),
        width = width(),
        ...
      )
    })

    return(list(selected = reactive(input[['select']])))

  }
