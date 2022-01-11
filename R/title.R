# title
#' Title creation for UI render
#'
#' @description A UI-side declaration of the title component
#' using the Framework 7 structure
#'
#' @param id The id used to reference the title object
#' @export
#' @importFrom shiny NS
title_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("title"))
}


#' Title creation for the server-side function
#'
#' @description THe server-side function for the title that is established a
#' `shinyMobile` application
#'
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param title_ The title as a string
#' @param size The size of the alignment object
#' @param align Logical. Determine whether or not we want to align the title with a specified  \code{side}
#' @param side Selected side for rendering the title with alignment
#' @export
#'
title_server <-
  function(input,
           output,
           session,
           title_ = NULL,
           size = NULL,
           align = F,
           side = c("left", "center", "right", "justify")) {
    session$ns -> ns
    title_ <- to_reactive(title_)
    size <- to_reactive(size)
    align <- to_reactive(align)
    side <- to_reactive(side)

    output[['title']] <- renderUI({
      out <- f7BlockTitle(title = title_())
      if (align())
        out %<>% f7Align(side = side())
      out
    })
  }
