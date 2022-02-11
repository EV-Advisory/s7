library(shiny)
library(f7)
library(dplyr)

shinyApp(
  ui = f7Page(
    title = "Stepper",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Stepper Example",
        hairline = TRUE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      stepper_ui("stepper"),
      f7Shadow(
        intensity = 16,
        hover = TRUE,
        f7Card(
          title = f7Icon("gear"),
          verbatimTextOutput("stepper")
        )
      )

    )
  ),
  server = function(input, output, session) {
    stepper <- callModule(stepper_server, id = 'stepper', label = 'Click me!')$step

    output[['stepper']] <- renderPrint({
      list(stepper = stepper())
    })
  }
)
