#'
#' Framework 7 Date Picker
#'
#' @description The framework 7 date Picker input that
#' relies on the shinyMobile package to develop
#' a compatible UI useful in PWAs
#'
#' @param id  the namespace id of the date picker UI
#' @param ... additional parameters to uiOutput function
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput
#'@export

date_ui <- function(id, ...) {
  ns <- NS(id)
  return(uiOutput(ns("date-ui")), ...)
}


#' Framework 7 date picker server-side logic
#'
#'
#' @description The server-side function used in
#' shinyMobile developed shiny applications
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param label The label on the date picker UI
#' @param val The default value set for the date picker UI
#' @param multiple Logical. Enable multiple selection of choices
#' @param minDate Minimum date option for the date picker UI
#' @param maxDate Minimum date option for the date picker UI
#' @param ... Additional parameters for f7DatePicker()
#'
#'@importFrom shinyMobile f7DatePicker
#' @export


date_server <-
  function(input,
           output,
           session,
           val = Sys.Date(),
           multiple = T,
           label = "Pick a Date",
           minDate = as.Date("2020-01-01"),
           maxDate = Sys.Date() + 15,
           ...
           ) {
    session$ns -> ns

    val <- to_reactive(val)
    multiple <- to_reactive(multiple)
    label <- to_reactive(label)
    maxDate <- to_reactive(maxDate)
    minDate <- to_reactive(minDate)

    output[['date-ui']] <- renderUI({
      return(
        f7DatePicker(
          inputId = ns("date"),
          value = val(),
          multiple = multiple(),
          label = label(),
          maxDate = maxDate(),
          minDate = minDate(),
          ...
        )
      )
    })

    return(list(date = reactive(input[['date']])))
  }
