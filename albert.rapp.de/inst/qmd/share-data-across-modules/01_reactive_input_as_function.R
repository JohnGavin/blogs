library(ggplot2)
library(shiny)

ui <- bslib::page_fluid(
  selectInput(
      "dropdown",
      "Choose a chart",
      choices = c("bar", "boxplot")
  ),
  plot_UI("plot")
)

plot_UI <- function(id) {
  ns <- NS(id)
  tagList(
    plotOutput(ns("plot"))
  )
}

plot_Server <- function(id, dropdown_choice) {
  moduleServer(
    id,
    function(input, output, session) {
      output$plot <- renderPlot({
        if (dropdown_choice == "bar") {
##
          p <- ggplot(
            mtcars, aes(x = factor(cyl))
          ) +
            geom_bar(fill = 'dodgerblue4')
##
        } else {
##
          p <- ggplot(
            mtcars, aes(x = factor(cyl), y = mpg)
          ) +
            geom_boxplot(
              color = 'dodgerblue4',
              linewidth = 1.5
            )
##
        }
##
        p +
          theme_minimal(base_size = 16)
      })
    }
  )
}

# make param reactiveValues()/oberve() instead of reactive()
server <- function(input, output, session) {
  # Use reactiveValues() instead of reactive()
  shared_data <- reactiveValues()
  # observe (not reactive()) each list-element
  observe({
     shared_data$dropdown_choice <- input$dropdown
  })
##
  plot_Server(
    "plot",
    shared_data
  )
}

# Rename argument to `shared_data`
server <- function(input, output, session) {
  dropdown_choice <- reactive(input$dropdown)
  plot_Server(
    "plot",
    dropdown_choice # pass reactive instead of value
  )
}

plot_Server <- function(id, dropdown_choice) {
  moduleServer(
    id,
    function(input, output, session) {
##
      output$plot <- renderPlot({
        # CALL REACTIVE HERE WITH ()
        if (dropdown_choice() == "bar") {
##
          p <- ggplot(
            mtcars, aes(x = factor(cyl))
          ) +
            geom_bar(fill = 'dodgerblue4')
##
        } else {
##
          p <- ggplot(
            mtcars, aes(x = factor(cyl), y = mpg)
          ) +
            geom_boxplot(
              color = 'dodgerblue4',
              linewidth = 1.5
            )
##
        }
##
        p +
          theme_minimal(base_size = 16)
      })
    }
  )
}
##
shinyApp(ui, server)
