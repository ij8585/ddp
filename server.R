#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# library(shiny)
# library(UsingR)
# data(galton)
# 
# shinyServer(  
#   function(input, output) {    
#     output$newHist <- renderPlot({      
#       hist(galton$child, xlab='child height', col='lightblue',main='Histogram')      
#       mu <- input$mu      
#       lines(c(mu, mu), c(0, 200),col="red",lwd=5)      
#       mse <- mean((galton$child - mu)^2)      
#       text(63, 150, paste("mu = ", mu))      
#       text(63, 140, paste("MSE = ", round(mse, 2)))      
#     })      }
# )



# 
# library(shiny)
# library(mclust)
# 
# function(input, output, session) {
#   
#   # Create a spot where we can store additional
#   # reactive values for this session
#   val <- reactiveValues(x=NULL, y=NULL)    
#   
#   # Listen for clicks
#   observe({
#     # Initially will be empty
#     if (is.null(input$clusterClick)){
#       return()
#     }
#     
#     isolate({
#       val$x <- c(val$x, input$clusterClick$x)
#       val$y <- c(val$y, input$clusterClick$y)
#     })
#   })
#   
#   # Count the number of points
#   output$numPoints <- renderText({
#     length(val$x)
#   })
#   
#   # Clear the points on button click
#   observe({
#     if (input$clear > 0){
#       val$x <- NULL
#       val$y <- NULL
#     }
#   })
#   
#   # Generate the plot of the clustered points
#   output$clusterPlot <- renderPlot({
#     
#     tryCatch({
#       # Format the data as a matrix
#       data <- matrix(c(val$x, val$y), ncol=2)
#       
#       # Try to cluster       
#       if (length(val$x) <= 1){
#         stop("We can't cluster less than 2 points")
#       } 
#       suppressWarnings({
#         fit <- Mclust(data)
#       })
#       
#       mclust2Dplot(data = data, what = "classification", 
#                    classification = fit$classification, main = FALSE,
#                    xlim=c(-2,2), ylim=c(-2,2))
#     }, error=function(warn){
#       # Otherwise just plot the points and instructions
#       plot(val$x, val$y, xlim=c(-2, 2), ylim=c(-2, 2), xlab="", ylab="")
#       text(0, 0, "Unable to create clusters.\nClick to add more points.")
#     })
#   })
# }




library(shiny)
library(datasets)

# Define server logic required to summarize and view the 
# selected dataset
function(input, output) {
  
  # Return the requested dataset
  datasetInput <- reactive({
    switch(input$dataset,
           "pressure" = pressure,
           "women" = women,
           "cars" = cars)
  })
  
  # Generate a summary of the dataset
  output$summary <- renderPrint({
    summary( datasetInput())
  })
  
  # Show the first "n" observations
  output$view <- renderTable({
    head(datasetInput(), n = input$obs)
  })
  
  
  
  output$plot <- renderPlot({
 
  if (input$dataset == "cars") {
  
    plot(cars, xlab = "Speed", ylab = "Stopping distance", las = 1, cex = input$size, pch = 19)
    lines(lowess(cars$speed, cars$dist, f = 2/3, iter = 3), col = input$col)
    title(main = "Cars data")
    
  } 
    
  if (input$dataset == "pressure")  {

    plot(pressure, xlab = "Temperature", ylab = "Pressure", las = 1, cex = input$size,  pch = 19)
    
    lines(lowess(pressure$temperature, pressure$pressure, f = 2/3, iter = 3), col = input$col)
    title(main = "Pressure data")
    
  } 
    
  if  (input$dataset == "women")  {
    
    plot(women, xlab = "Height", ylab = "Weight", las = 1, cex = input$size,  pch = 19)
    
    lines(lowess(women$height, women$weight, f = 2/3, iter = 3), col = input$col)
    title(main = "Women data")
    
  }    
    
    
  
    
  })
  
  
}
