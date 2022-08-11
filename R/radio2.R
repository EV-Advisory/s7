#'
#' Framework 7 Radio Button
#'
#' @description The framework 7 radio button input that
#' relies on the shinyMobile package to develop
#' a compatible UI useful in PWAs
#'
#' @param id  the namespace id of the radio UI
#' @param ... parameters passed to the uiOutput
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput
#'@export

radio_ui <- function(id, ...) {
  ns <- NS(id)
  uiOutput(ns("radio-ui"), ...)
}


#' Framework 7 radio button server-side logic
#'
#'
#' @description The server-side function used in
#' shinyMobile developed shiny applications
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#'
#' @importFrom stats setNames
#' @inheritDotParams shinyMobile::f7Radio
#' @export

radio_server <-
  function(input,
           output,
           session,
           ...) {

    #Gather the session namespace for the module
    session$ns -> ns

    #Collect all of the passed parameters
    dotlist <- list(...)

    #From all of the collected parameters...
    reactive_list <- setNames(lapply(dotlist, function(x) {
      # Ensure that the item, if multiple exist, has a numeric naming index
      if (is.null(names(x)))
        names(x) <- 1:length(x)

      #Convert the item to a reactive function
      out <- do.call(
        what = to_reactive,
        args = list(x),
        envir = globalenv()
      )
      return(out)

    }), nm = names(dotlist))# Export the items into a named list
    #Render the output of the UI visually
    output[['radio-ui']] <- renderUI({
      #Ensure that the selection UI parameters
      req(exists("reactive_list"),
          !is.null(reactive_list),
          !is.null(reactive_list[['choices']]))

      #With do.call, convert all of the items into parameters that can be rendered as UI configurations
      do.call(shinyMobile::f7Radio, c(
        list(inputId = ns("radio")),
        lapply(reactive_list, function(x)
          isolate(x()))), quote = T)
    })

    #Return the result of the input as `selected`
    return(list(selected = reactive({
      req(input[['radio']])
      input[['radio']]
    })))
  }
