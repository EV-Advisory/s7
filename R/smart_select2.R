#'
#' Framework 7 select
#'
#' @description The framework 7 select input that
#' relies on the shinyMobile package to develop
#' a compatible UI useful in PWAs
#'
#' @param id  the namespace id of the select UI
#' @param ... parameters passed to the uiOutput
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput
#'@export

smart_select2_ui <- function(id, ...) {
  ns <- NS(id)
  uiOutput(ns("select-ui"), ...)
}


#' Framework 7 smart select server-side logic
#'
#'
#' @description The server-side function used in
#' shinyMobile developed shiny applications
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param ... Additional parameters for f7SmartSelect()
#'
#' @importFrom stats setNames
#' @inheritParams shinyMobile::f7SmartSelect
#' @export


smart_select2_server <-
  function(input,
           output,
           session,
           ...) {
    #Get the session namespace
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


    output[['select-ui']] <- renderUI({
      #Ensure that the selection UI parameters
      req(exists("reactive_list"),
          !is.null(reactive_list),
          !is.null(reactive_list[['choices']]))

      #With do.call, convert all of the items into parameters that can be rendered as UI configurations
      do.call(shinyMobile::f7SmartSelect, c(
        list(inputId = ns("select")),
        lapply(reactive_list, function(x)
          isolate(x()))
      ), quote = T)
    })

    return(list(selected = reactive(input[['select']])))

  }
