#ui.R
library(shiny)
inData=read.csv("~/Downloads/ShinyServer 5/inData.csv")
inData=inData[2:length(inData)]
shinyUI(
  fluidPage(
  
  titlePanel("Plant/Fungi Analysis"),
  
  sidebarLayout(
    sidebarPanel(
      radioButtons('selPlot', "Plot Type", c("Point" = "point", "Boxplot" = "box")), #selects plot type
      radioButtons('title', "Plot Title", c("Yes", "No")), #controls if title appears
      selectInput('xVar', 'X-axis', names(inData)), #selects X axis variable
      selectInput('yVar', 'Y-axis', names(inData)), #selects Y axis variable
      selectInput('fac', 'Factor', names(inData)), #selects what to factor by
      checkboxInput('fGo', "Turn on faceting?", value=FALSE), #controls if faceting is on or not
      selectInput('facet', 'Facet', names(inData)), #selects faceting factor
      br(),
      br(),
      #fileInput('file1', 'Choose file to upload', #uploading needs some work but is almost there. Needs to create inData file
      #          accept = c(
      #            'text/csv',
      #            'text/comma-separated-values',
      #            'text/tab-separated-values',
      #            'text/plain',
      #            '.csv',
      #            '.tsv'
      #          ),
      #),
      #actionButton('uplo', "Go"),
      br(),
      #downloadButton('down', "Download Plot", class=NULL)
      downloadButton('downloadPlot', 'Download Plot')
      
    ),
  
    mainPanel(
      plotOutput('plot1'),
      imageOutput('pho')
      )
    )
  )
)

