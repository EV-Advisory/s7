#' THe Card UI for Framework 7
#'
#' The card creates a server-side function to be handled
#' by conditional logic at later dates
#'
#' @param id is unique ID associated with the button for the UI namespace
#'
#' @import shiny
#'
#' @export
card_ui <- function(id) {
  ns <- NS(id)
  uiOutput(ns("card-ui"))
}



#' THe value box server for Framework 7
#'
#' The value box creates a server-side function to be handled
#' by conditional logic at later dates for the parameters
#'
#'
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param name The title of the card
#' @param image The image used for an expandable card
#' @param footer The footer appended to the bottom of the card
#' @param outline Outline style of the card
#' @param height The complete height of the card
#' @param ... The other components of the card UI
#'
#' @importFrom shinyMobile f7Card
#' @export
#'
card_server <- function(input,
                        output,
                        session,
                        name,
                        image = NULL,
                        footer = NULL,
                        outline = NULL,
                        height = NULL,
                        ...) {

  name <- to_reactive(name)
  image_ <- to_reactive(image)
  footer <- to_reactive(footer)
  outline <- to_reactive(outline)
  height <- to_reactive(height)


  output[['card-ui']] <- renderUI(shinyMobile::f7Card(
    title = name(),
    image = image_(),
    footer = footer(),
    outline = outline(),
    height = height(),
    ...
  ))
}
