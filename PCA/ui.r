library(ggvis)
library(shiny)
library(rsconnect) 


shinyUI(
  
  pageWithSidebar(
    
    headerPanel("hw4_108753208"),
    sidebarPanel(
      
      
      conditionalPanel(condition="input.tabselected==1",
                       selectInput("pp", "select the desired comparison", choices=c("PCA1,PCA2"="A","PCA1,PCA3"="B","PCA1,PCA4"="C","PCA2,PCA3"="D","PCA2,PCA4"="E","PCA3,PCA4"="F"), 
                                   selected = "PCA1,PCA2")
      ),
      conditionalPanel(condition="input.tabselected==2",
                       sliderInput("nums","Number of points:",min = 1,max = 150,value = 30)
      ),conditionalPanel(condition="input.tabselected==3",
                      h4("Iris Dataset")
      ),
      conditionalPanel(condition="input.tabselected==4",
                       radioButtons("abb","Different Attribute",list("Sepal.Length"="A1","Sepal.Width"="A2","Petal.Length"="A3","Petal.Width"="A4")),
                       br(),
                       sliderInput("bins","Number of bins:",min = 1,max = 50,value = 30)
      )
      
    ),
    mainPanel(

      tabsetPanel(
        tabPanel("PCA analysis", value=1, plotOutput("distPlot"),tableOutput("mytable10")),
        tabPanel("Correspondence Analysis", value=2,plotOutput("ca"),tableOutput("mytable4"),tableOutput("mytable5")),
        tabPanel("About our data", value=3, DT::dataTableOutput("mytable3")),
        tabPanel("Histogram", value=4, plotOutput("hist")),
        id = "tabselected"
      )
    )
    
  )
  
)
  
  
################################################################################
#shinyUI(pageWithSidebar(
#  div(),
#  sidebarPanel(
#    sliderInput("n", "Number of points", min = 1, max = nrow(mtcars),
#                value = 10, step = 1),
#    uiOutput("plot_ui")
#  ),
#  mainPanel(
#    ggvisOutput("plot"),
#    tableOutput("mtc_table")
#  )
#))