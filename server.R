####ggShiny Server 5/28/15 Lovett & Solomon####

library(shiny)
library(ggplot2)
inData=read.csv("~/GitHub/ggShiny/inData.csv")
inData=inData[2:length(inData)]
shinyServer(function(input, output){
  pOut <- reactive({
    
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
    if (input$selPlot=="bar") { #selects bar plot
        ggtype = geom_bar(stat="identity", position="dodge", aes_string(fill=input$fac))
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
    print(pOut()) #outputs our plot
  })
  
  #output$down <- downloadHandler({ #download, will work in future
  #  filename=function() {paste(input$fileName, '.png')}
  #  
  #  content = function(file) {ggsave(file, pOut())}
  #})
  output$downloadPlot <- downloadHandler(
    filename = function() {
      paste(input$yVar, ' by ', input$xVar, ' Plot ', Sys.Date(), '.jpg', sep='')
    },
    content = function(file) {
      ggsave(file, pOut(), scale=2)
    }
  )
})