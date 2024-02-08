library(shiny)
library(ggvis)
library(rsconnect) 
library(devtools)
library(ggplot2)
library(plyr)
library(scales)
library(grid)
library(ggbiplot)
library(ca)
library(FactoMineR)
data(iris)


shinyServer(
  
  function(input, output) {
    
    
    output$distPlot <- renderPlot({
      
      log.ir <- log(iris[, 1:4])
      ir.species <- iris[, 5]
      
      ir.pca <- prcomp(log.ir,center = TRUE, scale. = TRUE)
      
      sel<-input$pp
      
      if(sel=="A"){
        test<-c(1,2)
      }
      
      if(sel=="B"){
        test<-c(1,3)
      }
      
      if(sel=="C"){
        test<-c(1,4)
      }
      
      if(sel=="D"){
        test<-c(2,3)
      }
      
      if(sel=="E"){
        test<-c(2,4)
      }
      
      if(sel=="F"){
        test<-c(3,4)
      }
      
      
      ggbiplot(ir.pca,ellipse=TRUE,choices=test,obs.scale = 1, var.scale = 1, groups = ir.species)+ scale_color_discrete(name = '')+ theme(legend.direction = 'horizontal', legend.position = 'top')
      
    
    })
    
   
    ##
    
    output$ca <- renderPlot({
      
      nn<-input$nums
      ca2 = CA(iris[1:nn,1:4], graph = FALSE)
      
      plot(ca2)

      
    })
    
    ##
    output$mytable3 <- DT::renderDataTable({
      
      DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
      
    })
    
    ##
    output$mytable4 <- renderTable({
      
      nn<-input$nums
      sasa = CA(iris[1:nn,1:4], graph = FALSE)
      
      res<-sasa$col$contrib
      
      
      
    },include.rownames=TRUE)
    
    ##
    output$mytable5 <- renderTable({
      
      nn2<-input$nums
      sasa2 = CA(iris[1:nn2,1:4], graph = FALSE)
      
      res2<-sasa2$eig
      
      
      
    },include.rownames=TRUE,digits=6)
    
    ##
    output$hist <- renderPlot({
      
      sel2<-input$abb
      
      if(sel2=="A1"){
        test2<-1
      }
      
      if(sel2=="A2"){
        test2<-2
      }
      
      if(sel2=="A3"){
        test2<-3
      }
      
      if(sel2=="A4"){
        test2<-4
      }
      
      RR<-nrow(iris)
      x <- iris[1:RR,test2]
      
      bins <- seq(min(x), max(x), length.out = input$bins + 1)
      
      hist(x, breaks = bins, col = "#75AADB", border = "white",
           xlab = "Attribute value",
           main = "Histogram")
      
    })
    
    output$mytable10 <- renderTable({
      
      rr<-nrow(iris)
      log.ir <- log(iris[1:rr, 1:4])
      
      ir.pca <- prcomp(log.ir,center = TRUE, scale. = TRUE)
      
      summary(ir.pca)$importance
      
      
    },include.rownames=TRUE,digits=5)
    
    
  }
  
)


############################################################
#shinyServer(function(input, output, session) {
#  # A reactive subset of mtcars
#  mtc <- reactive({ mtcars[1:input$n, ] })

  # A simple visualisation. In shiny apps, need to register observers
  # and tell shiny where to put the controls
#  mtc %>%
#    ggvis(~wt, ~mpg) %>%
#    layer_points() %>%
#    bind_shiny("plot", "plot_ui")

#  output$mtc_table <- renderTable({
#    mtc()[, c("wt", "mpg")]
#  })
#})
