# Load packages ----------------------------------------------------------------
library(shiny)
library(tidyverse)

# Load data --------------------------------------------------------------------
load("movies.Rdata")

# Define UI for application that plots features of movies ----------------------
ui <- fluidPage(
  
  # Sidebar layout with a input and output definitions -------------------------
  sidebarLayout(
    
    # Inputs: Select variables to plot -----------------------------------------
    sidebarPanel(
      
      # Select variable for y-axis ---------------------------------------------
      selectInput(inputId = "y", 
                  label = "Y-axis:",
                  choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                  selected = "audience_score"),
      
      # Select variable for x-axis ---------------------------------------------
      selectInput(inputId = "x", 
                  label = "X-axis:",
                  choices = c("imdb_rating", "imdb_num_votes", "critics_score", "audience_score", "runtime"), 
                  selected = "critics_score"),

      # Select variable for color ----------------------------------------------
      selectInput(inputId = "z", 
                  label = "Color by:",
                  choices = c("title_type", "genre", "mpaa_rating", "critics_rating", "audience_rating"),
                  selected = "mpaa_rating")
    ),
    
    # Output: Show scatterplot -------------------------------------------------
    mainPanel(
      plotOutput(outputId = "scatterplot")
    )
  )
)

# Define server function required to create the scatterplot --------------------
server <- function(input, output) {
  
  # Create scatterplot object the plotOutput function is expecting -------------
  output$scatterplot <- renderPlot({
    ggplot(data = movies, aes_string(x = input$x, y = input$y, 
                                     color = input$z)) +
      geom_point()
  })
}

# Create the Shiny app object --------------------------------------------------
shinyApp(ui = ui, server = server)
