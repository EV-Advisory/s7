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
          f7::toggle_ui("chart_show"),
          apexchartOutput("areaChart")
        )
      )
    )
  ),
  server = function(input, output,session) {
    toggle<-callModule(f7::toggle_server,id = 'chart_show',label_ = 'Click Me!')$value

    output$areaChart <- renderApexchart({
      req(toggle())
      apex(
        data = economics_long,
        type = "area",
        mapping = aes(
          x = date,
          y = value01,
          fill = variable
        )
      ) %>%
        ax_yaxis(decimalsInFloat = 2) %>% # number of decimals to keep
        ax_chart(stacked = TRUE) %>%
        ax_yaxis(max = 4, tickAmount = 4)
    })
  }
)
