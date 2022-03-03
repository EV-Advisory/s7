library(shiny)
library(f7)
library(shinyMobile)
library(apexcharter)
library(ggplot2)

data("economics_long")
economics_long <- economics_long %>%
  group_by(variable) %>%
  slice((n()-100):n())



shinyApp(
  ui = f7Page(
    title = "Apex",
    f7SingleLayout(
      navbar = f7Navbar(
        title = "Apex Example",
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
          apex_ui("chart")
        )
      )

    )
  ),
  server = function(input, output, session) {

    callModule(apex_server,id = 'chart',apexc = reactive({
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
    }))

  }
)
