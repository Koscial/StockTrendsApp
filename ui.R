#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(navbarPage(
    "Stock Trends for Major European Indices",
    
    tabPanel("Documentation",
             
             h1("Documentation"),
             
             p("By default the application plots daily closing prices of the 4 most important stock indices in Europe: German DAX, Swiss SMI, French CAC and British FTSE. The data comes from the", code("datasets"), "package and are sampled only on business days (excl. weekends and holidays), from Jan 1991 to Dec 1998, giving 1860 observations."),
             p("The interactivity of the application pertains to the user being able to change several characteristics of the graph. On the sidebar panel the user is able to select the following:"),
             HTML("<ul>
                      <li>Time range of the plot</li>
                      <li>Prices of which indices to show</li>
                      <li>Whether to fit linear trends to the displayed graphs</li>
                  </ul>")
             
    ),
    
    tabPanel("Application",
             
             sidebarLayout(
                 
                 sidebarPanel(
                     
                     h3("Time interval"),
                     "1 stands for 1 Jan 1991",
                     br(),
                     "1860 stands for 31 Dec 1998",
                     sliderInput("timeInterval", "", min = 1, max = 1860, value = c(1,1860)),
                     hr(),
                     
                     h3("Which indices to show?"),
                     checkboxInput("DAX", "DAX", TRUE),
                     checkboxInput("SMI", "SMI", TRUE),
                     checkboxInput("CAC", "CAC", TRUE),
                     checkboxInput("FTSE", "FTSE", TRUE),
                     hr(),
                     
                     selectInput("fit", h3("Fit linear trends?"), choices = list("Yes" = 1, "No" = 2), selected = 2),
                     hr(),
                     
                     submitButton()
                 ),
                 
                 mainPanel(
                     
                     h1("Requested plot"),
                     
                     plotOutput("plot")
                     
                 )
                 
             )
    )
))
