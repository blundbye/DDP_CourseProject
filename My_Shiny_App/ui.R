library(shiny)
shinyUI(fluidPage(
  titlePanel("Diamond Price vs. Carat Size"),
  sidebarLayout(
    sidebarPanel(    
    h3("Select quality of cut"),
    checkboxInput("cut_1", "Ideal", FALSE),
    checkboxInput("cut_2", "Premium", FALSE),
    checkboxInput("cut_3", "Very Good", TRUE),
    checkboxInput("cut_4", "Good", FALSE),
    checkboxInput("cut_5", "Fair", FALSE),
      h3("Slope"),
      textOutput("slopeOut"),
      h3("Intercept"),
      textOutput("intOut")
    ),
    mainPanel(
      plotOutput("plot1", brush = brushOpts(
        id = "brush1"
      )),
      h3("Notes:"),
      h5("This app generates the linear fit of Price vs. Carat mass from a sample set of data points from the diamonds data set."),
      h5("In order to get the fitted values (the red line) you have to brush over at least 5 observations."),
      h5("The app then calculates and shows the slope and intercept of the fitted line in the side panel."),
      h5("Here you can also select the level of quality of the diamonds")
    )
  )
))