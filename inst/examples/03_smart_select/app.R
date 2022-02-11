library(shiny)
library(f7)
library(dplyr)

shinyApp(
  ui = f7Page(
    title = "Smart Select",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Smart Select Example",
        hairline = TRUE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      smart_select_ui("smart_select"),
      smart_select_ui("smart_select_multiple"),
      f7Shadow(
        intensity = 16,
        hover = TRUE,
        f7Card(
          title = f7Icon("gear"),
          verbatimTextOutput("smart_select")
        )
      )

    )
  ),
  server = function(input, output, session) {
    smart_select <- callModule(smart_select_server, id = 'smart_select', label = 'Pick one',multiple = F, choices = c(1:10),openIn = 'popup')$selected
    smart_selectm <- callModule(smart_select_server, id = 'smart_select_multiple', label = 'Pick multiple',multiple = T, choices = LETTERS[c(1:10)])$selected

    output[['smart_select']] <- renderPrint({
      # req(is.numeric(smart_select()))
      list(select_single = smart_select(),select_multiple = smart_selectm())
      # list(slider_single = slider(),slider_multiple = sliderm())
    })
  }
)
