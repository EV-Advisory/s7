library(shiny)
library(apexcharter,quietly = T)
suppressPackageStartupMessages(library(dplyr,quietly = T))
library(ggplot2,quietly = T)

data("economics_long")
economics_long <- economics_long %>%
  group_by(variable) %>%
  slice((n()-100):n())


shinyApp(
  ui = f7Page(
    title = "Toggle",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Toggle Example",
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
          dt_ui("dt")
        )
      )
    )
  ),
  server = function(input, output,session) {
    callModule(dt_server,id = 'dt',base_data = reactive(economics_long))
  }
)
