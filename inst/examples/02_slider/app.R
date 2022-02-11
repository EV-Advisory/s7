library(shiny)
library(f7)
library(dplyr)

shinyApp(
  ui = f7Page(
    title = "Slider",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Slider Example",
        hairline = TRUE,
        shadow = TRUE
      ),
      toolbar = f7Toolbar(
        position = "bottom",
        f7Link(label = "Link 1", href = "https://www.google.com"),
        f7Link(label = "Link 2", href = "https://www.google.com")
      ),
      # main content
      f7Shadow(
        intensity = 16,
        hover = TRUE,
        f7Card(
          title = f7Icon("gear"),
          f7::slider_ui("slider"),
          f7::slider_ui("slider_multiple"),
          verbatimTextOutput("slider")
        )
      )
    )
  ),
  server = function(input, output, session) {
    slider <- callModule(f7::slider_server, id = 'slider', label_ = 'Slide on!')$value
    sliderm <- callModule(f7::slider_server, id = 'slider_multiple', label_ = 'Slide on!',value_ = c(1,30))$value

    output[['slider']] <- renderPrint({
      req(is.numeric(slider()))
      list(slider_single = slider(),slider_multiple = sliderm())
    })
  }
)
