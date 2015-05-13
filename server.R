library(shiny)
library(maps)

data <- as.data.frame(state.x77)
data <- cbind(Statename = rownames(data), data)
rownames(data)<-NULL

shinyServer(
  function(input, output) {
    
    output$uimaptitle <- renderUI({
      if(input$statename == ""){
        titlestring <- "The map of USA states"
      }else{
        titlestring <- paste("The location of ", input$statename, "state")
      }
      h4(titlestring, align = "center")
    })
    
    output$map <- renderPlot({
      map("state.vbm", fill = FALSE)
      if(input$statename != ""){
        map("state.vbm", regions = input$statename, 
            fill = TRUE, add = TRUE, col = "blue")
      }     
    })
    
    output$uidetailtitle <- renderUI({
      if(input$showdetail){
        if(input$statename == ""){
          titlestring <- "The detail of USA states"
        }else{
          titlestring <- paste("The detail of ", input$statename, "state")
        }
        h4(titlestring, align = "center")
      }
    })
    
    output$table <- renderDataTable({
      if(input$showdetail){
        tabledata <- data
        if (input$statename != ""){
          tabledata <- data[data$Statename==input$statename, ]
        }
        tabledata
      }
    }, options = list(lengthMenu = c(5,10,25), pageLength = 5))
    
  }
)
    


