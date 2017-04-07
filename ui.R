#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#





# library(shiny)
#  
# 
# shinyUI(pageWithSidebar(  
#   headerPanel("Example plot"),  
#   sidebarPanel(    
#     sliderInput('mu', 'Guess at the mu',value = 70, min = 60, max = 80, step = 0.05,)  ), 
#   mainPanel(    
#     plotOutput('newHist')  
#   )
# ))


#install.packages("mclust")


# 
# library(shiny)
# 
# # Create a bootstrap fluid layout
# fluidPage(
#   
#   # Add a title
#   titlePanel("Dynamic Clustering in Shiny"),
#   
#   # Add a row for the main content
#   fluidRow(
#     
#     # Create a space for the plot output
#     plotOutput(
#       "clusterPlot", "100%", "500px", click="clusterClick"
#     )
#   ),
#   
#   # Create a row for additional information
#   fluidRow(
#     # Take up 2/3 of the width with this element  
#     mainPanel("Points: ", verbatimTextOutput("numPoints")),
#     
#     # And the remaining 1/3 with this one
#     sidebarPanel(actionButton("clear", "Clear Points"))
#   )    
# )



library(shiny)

# Define UI for dataset viewer application
fluidPage(
  
  # Application title.
  titlePanel("Developing Data Products: Week 3 Assignment"),
  
  
  h4("ij8585"),
  h4("April 07, 2017"),
  
  helpText("This is data exploration application which presents basic statistics, visualize data and displays some observations of a selected dataset.","Use the control panel on the left to explore the data.,"Use the control panel on the left to explore the data. "), 
 
  sidebarLayout(

    

    sidebarPanel(
    
      selectInput("dataset", "Choose a dataset:", 
                  choices = c("pressure","cars","women")),  
      
      helpText("Select a data set for data exploration"), 
      

      radioButtons("col", "Line color", 
                  choices = c("blue", "red","green")),
      
      
      helpText("Pickup a color of the line in the data view"), 
      
      
      sliderInput('size', 'Point size', min = 0.5, max = 3, value = 1),
      
      helpText("Select a size of the points in the data view"), 
      
      numericInput("obs", "Number of observations to view:", 10) 
      
      

      
      #submitButton("Update View") 
      

    ),

    
   
 
    mainPanel(
      
      h4("Summary"),
      verbatimTextOutput("summary"),
      helpText("Note: while the data view will show only the specified",
               "number of observations, the summary and data view will still be based",
               "on the full dataset."),  
      
      h4("Data View"),
      plotOutput("plot"),
      helpText("Note: the size of the points and color of the line can be changed in the control panel on the left"),  
      
      
      h4("Observations"),
      tableOutput("view"),
      helpText("Note: the number of the observations can be changed in the control panel on the left")   
      
      
    )
  )
)