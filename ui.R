#ui.R
library(shiny)

shinyUI(
  fluidPage(
  
  titlePanel("ggShiny"),
  
  sidebarLayout(position="right",
    sidebarPanel(
      radioButtons('selPlot', "Plot Type", c("Point" = "point", "Boxplot" = "box", "Bar"="bar")), #selects plot type
      radioButtons('title', "Plot Title", c("Yes", "No")), #controls if title appears
      uiOutput('x'),
      uiOutput('y'),
      uiOutput('fact'),
      checkboxInput('fGo', "Turn on faceting?", value=FALSE), #controls if faceting is on or not
      uiOutput('face'),
      br(),
      br(),
      downloadButton('downloadPlot', 'Download Plot')
      
    ),
  
    mainPanel(
      plotOutput('plot1'),
      tags$hr(),
      fileInput('file1', 'Choose CSV File',
                accept=c('text/csv', 
                         'text/comma-separated-values,text/plain', 
                         '.csv')),
      tags$hr()#,
      #checkboxInput('header', 'Header', TRUE),
      #radioButtons('sep', 'Separator',
      #             c(Comma=',',
      #               Semicolon=';',
      #               Tab='\t'),
      #             ','),
      #radioButtons('quote', 'Quote',
      #             c(None='',
      #               'Double Quote'='"',
      #               'Single Quote'="'"),
      #             '"')
      )
    )
  )
)

