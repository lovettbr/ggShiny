library(shiny)
library(ggplot2)
shinyServer(function(input, output){
  output$x <- renderUI({
    inData <- input$file1
    if (is.null(inData))
      return(NULL)
    selectInput('xVar', 'X-axis', names(read.csv(inData$datapath, header=input$header, sep=input$sep, 
                                                 quote=input$quote)))
  })
  output$y <- renderUI({
    inData <- input$file1
    if (is.null(inData))
      return(NULL)
    selectInput('yVar', 'Y-axis', names(read.csv(inData$datapath, header=input$header, sep=input$sep, 
                                                 quote=input$quote)))
  })
  output$fact <- renderUI({
    inData <- input$file1
    if (is.null(inData))
      return(NULL)
    selectInput('fac', 'Factor', names(read.csv(inData$datapath, header=input$header, sep=input$sep, 
                                                quote=input$quote)))
  })
  output$face <- renderUI({
    inData <- input$file1
    if (is.null(inData))
      return(NULL)
    selectInput('facet', 'Facet', names(read.csv(inData$datapath, header=input$header, sep=input$sep, 
                                                quote=input$quote)))
  })
  
  pOut <- reactive({
    inData <- input$file1
    inData= read.csv(inData$datapath, header=input$header, sep=input$sep, 
                     quote=input$quote)
    if (is.null(inData))
      return(NULL)
    base=ggplot(inData, aes_string(x=input$xVar, y=input$yVar, color=input$fac))
    facet=facet_wrap(input$facet)
    if (input$selPlot == "point") { #selects point plot
      ggtype=geom_point()
      outP = base + ggtype
      if (input$fGo) { #if faceting is turned on
        outP = outP + facet
      }
    } 
    if (input$selPlot=="box") { #selects boxplot
      ggtype = geom_boxplot() 
      outP = base + ggtype
      if (input$fGo) { #if faceting is turned on
        outP = outP + facet
      }
      
    }
    
    if (input$title == "Yes") { #if title is selected to be on
      titleStr <- paste(input$yVar, ' by ', input$xVar, sep='')
      if (input$fGo) { #if faceting is called for
        titleStr= paste(titleStr, ', faceted by ', input$facet, sep='')
       outP + ggtitle(titleStr) + theme(plot.title = element_text(size = rel(2), colour = "blue"))
      } else {
        outP + ggtitle(titleStr)  + theme(plot.title = element_text(size = rel(2), colour = "blue"))
      }
      
    } else {
      outP
    }
  })
  
  output$plot1 <- renderPlot({
    inData <- input$file1
    if (is.null(inData))
      return(NULL)
    print(pOut()) #outputs our plot
  })
  
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste(input$yVar, ' by ', input$xVar, ' Plot ', Sys.Date(), '.jpg', sep='')
    },
    content = function(file) {
      ggsave(file, pOut())
    }
  )
})