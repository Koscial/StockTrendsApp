#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(tidyr)
library(dplyr)



# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    
    dataLogical <- reactive({(1:4)[c(input$DAX, input$SMI, input$CAC, input$FTSE)]})
    
    data <- reactive({as.data.frame(EuStockMarkets) %>% 
                        select(dataLogical()) %>%
                        gather(index, price) %>%
                        mutate(time = rep(time(EuStockMarkets), length(dataLogical())))})    
    
    output$plot <- renderPlot({
        
        min <- time(EuStockMarkets)[input$timeInterval[1]]
        max <- time(EuStockMarkets)[input$timeInterval[2]]
        
        
        g <- ggplot(data = data(), mapping = aes(x = time, y = price, colour = index)) +
            geom_line() +
            xlim(min, max) +
            xlab("Time") +
            ylab("Index price")
        
        if(input$fit == 1) {
            g <- g + geom_smooth(method = "lm", se = FALSE)
        }
        
        g
    })
    
})
