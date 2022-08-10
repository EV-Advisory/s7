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
          smart_select2_ui("vars"),
          apex_ui("chart")
        )
      )

    )
  ),
  server = function(input, output, session) {

    sel_var<-callModule(smart_select2_server, id = "vars",choices = setNames(c("All",unique(economics_long$variable)),nm = c("All",unique(economics_long$variable))),label = "Select a Variable:",openIn = 'popup')$selected

    chart_data<-reactive({
      req(sel_var())
      chart_df<-economics_long
      if(sel_var()!='All') return(chart_df%>%dplyr::filter(variable==sel_var())) else return(chart_df) })

    callModule(apex_server,id = 'chart',apexc = reactive({
      req(chart_data())
      apex_data<-isolate(chart_data())
      apex(
        data = apex_data,
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
    }),base_data = NULL)

  }
)
