library(shiny)
library(f7)
library(dplyr)

shinyApp(
  ui = f7Page(
    title = "Select",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Select Example",
        hairline = TRUE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      select_ui("select"),
      f7Shadow(
        intensity = 16,
        hover = TRUE,
        f7Card(
          title = f7Icon("gear"),
          verbatimTextOutput("select")
        )
      )

    )
  ),
  server = function(input, output, session) {
    select <- callModule(select_server, id = 'select', label = 'Pick one',choices = c(1:10))$selected

    output[['select']] <- renderPrint({
      # req(is.numeric(smart_select()))
      list(select_single = select())
      # list(slider_single = slider(),slider_multiple = sliderm())
    })
  }
)
