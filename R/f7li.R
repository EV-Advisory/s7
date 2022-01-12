#' Framework 7 list item
#'
#' @description A Framework 7 list item function
#' to conveniently build list group
#'
#'
#' @param id the namespace id of the list items
#'
#' @importFrom shiny uiOutput
#'
#' @export


f7li_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("li"))
}


#' Framework 7 list item
#'
#' @description The server-side integration of the framework 7
#' list items for use in an f7listgroup function call
#'
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param title Title used in the list item
#' @param subtitle The subtitle of the list item
#' @param header Header component of the list item
#' @param footer Footer component of the list item
#' @param href hyperlink reference for the list item group
#' @param media The reference for the framework 7 icon used in the list item
#' @param right The component on the righthand side of the list item
#' @param ... Item text
#'
#' @import shiny
#' @import shinyMobile
#'
#' @export

f7li_server <-
  function(input,
           output,
           session,
           title = NULL,
           subtitle = NULL,
           header = NULL,
           footer = NULL,
           href = NULL,
           media = NULL,
           right = NULL,
           ...) {

    t_ <- to_reactive(title)
    s_ <- to_reactive(subtitle)
    h_ <- to_reactive(header)
    f_ <- to_reactive(footer)
    hr_ <- to_reactive(href)
    m_ <- to_reactive(media)
    ri_ <- to_reactive(right)

    output[['li']] <- renderUI({
      req(lapply(ls(envir = parent.frame()), function(x) {
        eval(parse(text = paste0(x, "()")))
      }))

      f7ListItem(
        ... = ...,
        title = t_(),
        subtitle = s_(),
        header = h_(),
        footer = f_(),
        href = hr_(),
        media = f7Icon(m_()),
        right = ri_()
      )
    })
  }
