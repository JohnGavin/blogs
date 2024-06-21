params <-
list(source_git = "https://github.com/AlbertRapp/3mw_newsletters/blob/master/82_Jun_19_2024/82_Jun_19_2024.qmd",
    source_website = "https://3mw.albert-rapp.de/p/share-data-across-modules")

## fn_in <- here("inst", "qmd", "share-data-across-modules", "share-data-across-modules.qmd")
## fn_out <- here("inst", "qmd", "share-data-across-modules", "share-data-across-modules.R")
## knitr::purl(input = fn_in, output = fn_out, documentation = 0)
##

# setwd(here::here('82_Jun_19_2024'))
library(tidyverse)

theme_set(
  theme_minimal(
    base_size = 16,
    base_family = 'Source Sans Pro'
  ) +
    theme(panel.grid.minor = element_blank())
)

## library(shiny)
## ui <- bslib::page_fluid(
##   selectInput(
##       "dropdown",
##       "Choose a chart",
##       choices = c("bar", "boxplot")
##   ),
##   plot_UI("plot")
## )

## library(ggplot2)
## plot_UI <- function(id) {
##   ns <- NS(id)
##   tagList(
##     plotOutput(ns("plot"))
##   )
## }
##
## plot_Server <- function(id, dropdown_choice) {
##   moduleServer(
##     id,
##     function(input, output, session) {
##       output$plot <- renderPlot({
##         if (dropdown_choice == "bar") {
##
##           p <- ggplot(
##             mtcars, aes(x = factor(cyl))
##           ) +
##             geom_bar(fill = 'dodgerblue4')
##
##         } else {
##
##           p <- ggplot(
##             mtcars, aes(x = factor(cyl), y = mpg)
##           ) +
##             geom_boxplot(
##               color = 'dodgerblue4',
##               linewidth = 1.5
##             )
##
##         }
##
##         p +
##           theme_minimal(base_size = 16)
##       })
##     }
##   )
## }

## server <- function(input, output, session) {
##   plot_Server("plot", 'bar') # hard-code 2nd argument
## }
## shinyApp(ui, server)

## server <- function(input, output, session) {
##   plot_Server(
##     "plot",
##     input$dropdown # replace hard-coded argument
##   )
## }
## shinyApp(ui, server)

## server <- function(input, output, session) {
##   dropdown_choice <- reactive(input$dropdown)
##   plot_Server(
##     "plot",
##     dropdown_choice # pass reactive instead of value
##   )
## }

## plot_Server <- function(id, dropdown_choice) {
##   moduleServer(
##     id,
##     function(input, output, session) {
##
##       output$plot <- renderPlot({
##         # CALL REACTIVE HERE WITH ()
##         if (dropdown_choice() == "bar") {
##
##           p <- ggplot(
##             mtcars, aes(x = factor(cyl))
##           ) +
##             geom_bar(fill = 'dodgerblue4')
##
##         } else {
##
##           p <- ggplot(
##             mtcars, aes(x = factor(cyl), y = mpg)
##           ) +
##             geom_boxplot(
##               color = 'dodgerblue4',
##               linewidth = 1.5
##             )
##
##         }
##
##         p +
##           theme_minimal(base_size = 16)
##       })
##     }
##   )
## }
##
## shinyApp(ui, server)

## server <- function(input, output, session) {
##   # Use reactiveValues() instead of reactive()
##   shared_data <- reactiveValues()
##   observe({
##      shared_data$dropdown_choice <- input$dropdown
##   })
##
##   plot_Server(
##     "plot",
##     shared_data
##   )
## }

## # Rename argument to `shared_data`
## plot_Server <- function(id, shared_data) {
##   moduleServer(
##     id,
##     function(input, output, session) {
##
##       output$plot <- renderPlot({
##         # Use new notation to access the value
##         if (shared_data$dropdown_choice == "bar") {
##
##           p <- ggplot(
##             mtcars, aes(x = factor(cyl))
##           ) +
##             geom_bar(fill = 'dodgerblue4')
##
##         } else {
##
##           p <- ggplot(
##             mtcars, aes(x = factor(cyl), y = mpg)
##           ) +
##             geom_boxplot(
##               color = 'dodgerblue4',
##               linewidth = 1.5
##             )
##
##         }
##
##         p +
##           theme_minimal(base_size = 16)
##       })
##     }
##   )
## }
##
## shinyApp(ui, server)
