library(plotly)

# Sample of 100 observations from diamonds dataset where carat > .5 
set.seed(2017-07-17)
d <- diamonds[diamonds$carat > .5,][sample(nrow(diamonds[diamonds$carat > .5,]), 100), ]

library(shiny)

shinyServer(function(input, output) {
  
  dcut <- reactive({
    c_1 <- input$cut_1
    c_2 <- input$cut_2
    c_3 <- input$cut_3
    c_4 <- input$cut_4
    c_5 <- input$cut_5
    dc <- c("Ideal","Premium","Very Good","Good","Fair")
    select <- dc[c(c_1, c_2, c_3, c_4, c_5)]

    d[d$cut %in% select,]    
  })        
  
  model <- reactive({
    brushed_data <- brushedPoints(dcut(), input$brush1,
                                  xvar = "carat", yvar = "price")
    if(nrow(brushed_data) < 5){
      return(NULL)
      }
    lm(price ~ carat, data = brushed_data)
    })
  
  output$slopeOut <- renderText({
    if(is.null(model())){
      "Please brush over at least 5 observations"
      } else {
        model()[[1]][2]
        }
  })  
  
  output$intOut <- renderText({
    if(is.null(model())){
      "Please brush over at least 5 observations"
      } else {
        model()[[1]][1]
        }
  })

    output$plot1 <- renderPlot({
      validate(
        need(nrow(dcut()) > 0, "Please select at least one cut!!")    
        )
      plot(dcut()$carat, dcut()$price, 
         xlab = "Mass (carats)",
         ylab = "Price (SIN $)", 
         bg = "lightblue",
         col = "black", cex = 1.1, pch = 21, bty = "n")
      if(!is.null(model())){
        abline(model(), col = "red", lwd = 2)
        }
    })
    
})