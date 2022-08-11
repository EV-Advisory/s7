#'
#' Data Table (DT) UI
#'
#' @description The Datatable UI for the client side
#' used in a Framework 7 shiny application
#'
#' @param id  the namespace id of the radio UI
#' @param ... parameters passed to the uiOutput
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput
#'@export
dt_ui <- function(id, ...) {
  ns <- NS(id)
  uiOutput(ns("dt"), ...)
}

#'
#' Datatable (DT) Server side
#'
#' @description The DT server-side functionality
#' used in a Framework 7 application
#'
#' @param input list of inputs used in the shiny application session
#' @param output list of outputs used the shiny application session
#' @param session The shiny app session object
#' @param base_data A data frame to display within the datatable() function call
#' @param row_n Boolean. TRUE or FALSE to include row names (converted to reactive on server side)
#' @param col_names Character. Accepts a character array that corresponds to the columns in the data frame
#' @param currency_pattern Character. Regular expression for finding the columns that have a currency format
#' @param pct_pattern Character. Regular expression for finding the columns that have a percent format
#' @param opts List. A list of additional options that are passed to DT::datatable(... options = opts)
#' @param dt_height Character. A pixel, em or css height adjustment for the datatable rendered
#' @param s Boolean. Toggle whether to have a server side or client side rendering of the datatable's data (Default = T)
#' @param escape Boolean. Toggle whether to escape HTML rendering (Default = F)
#'
#'@importFrom shiny NS
#'@importFrom shiny uiOutput
#'@importFrom DT renderDataTable
#'@importFrom DT dataTableOutput
#'@importFrom DT datatable
#'@importFrom DT formatCurrency
#'@importFrom DT formatPercentage
#'@export

dt_server <-
  function(input,
           output,
           session,
           base_data,
           row_n = T,
           col_names = NULL,
           currency_pattern = "sales|aov|budg\\w+",
           pct_pattern = "\\%",
           opts = list(),
           dt_height = NULL,
           s = T,
           escape = F) {
    ns <- session$ns

    base_data <- to_reactive(base_data)
    row_n <- to_reactive(row_n)
    col_names <- to_reactive(col_names)

    output[['dt']] <- renderUI({
      req(base_data())
      DT::dataTableOutput(ns('DT'), height = dt_height)
    })

    output[['DT']] <- DT::renderDataTable({
      req(nrow(base_data()) > 0)
      coln <-
        `if`(is.null(col_names()), names(base_data()), col_names())
      dtable <-
        DT::datatable(
          base_data(),
          rownames = row_n(),
          colnames = coln,
          options = opts,
          escape = escape
        )
      if (length(which(grepl(currency_pattern, tolower(coln)))) > 0)
        dtable %<>% formatCurrency(which(grepl(currency_pattern, tolower(coln))), digits = 0)
      if (length(which(grepl(pct_pattern, tolower(coln)))) > 0)
        dtable %<>% formatPercentage(which(grepl(pct_pattern, tolower(coln))))

      dtable
    }, server = s)
  }
